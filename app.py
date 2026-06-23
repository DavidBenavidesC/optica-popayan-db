# app.py
from flask import Flask, render_template, request, redirect, url_for, flash, session
from flask_mysqldb import MySQL
import MySQLdb.cursors
import hashlib
from config import Config
from functools import wraps

app = Flask(__name__)
app.config.from_object(Config)
mysql = MySQL(app)

# --- helpers ---
def hash_password(pw: str) -> str:
    return hashlib.sha256(pw.encode('utf-8')).hexdigest()

def login_required(f):
    @wraps(f)
    def decorated(*args, **kwargs):
        if 'user_id' not in session:
            return redirect(url_for('login'))
        return f(*args, **kwargs)
    return decorated

# --- Auth ---
@app.route('/login', methods=['GET','POST'])
def login():
    if request.method == 'POST':
        username = request.form['username']
        password = request.form['password']
        pw_hash = hash_password(password)
        cur = mysql.connection.cursor()
        cur.execute("SELECT usuario_id, username, nombre FROM usuario WHERE username=%s AND password_hash=%s", (username, pw_hash))
        user = cur.fetchone()
        cur.close()
        if user:
            session['user_id'] = user['usuario_id']
            session['username'] = user['username']
            session['nombre'] = user['nombre']
            flash('Inicio de sesión correcto')
            return redirect(url_for('index'))
        else:
            flash('Usuario o contraseña incorrectos', 'danger')
    return render_template('login.html')

@app.route('/logout')
def logout():
    session.clear()
    return redirect(url_for('login'))

# --- Home ---
@app.route('/')
@login_required
def index():
    return render_template('index.html')

# ---------------- CLIENTES ----------------
@app.route('/clientes')
@login_required
def clientes():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT c.*, u.nombre as usuario
        FROM cliente c
        LEFT JOIN usuario u ON c.created_by = u.usuario_id
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('clientes.html', clientes=data)

@app.route('/clientes/nuevo', methods=['GET','POST'])
@login_required
def nuevo_cliente():
    if request.method == 'POST':
        tipo_documento = request.form.get('tipo_documento') or None
        numero_documento = request.form.get('numero_documento') or None
        nombre = request.form['nombre']
        direccion = request.form.get('direccion') or None
        telefono = request.form.get('telefono') or None
        email = request.form.get('email') or None
        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO cliente (tipo_documento, numero_documento, nombre, direccion, telefono, email, created_by)
            VALUES (%s,%s,%s,%s,%s,%s,%s)
        """, (tipo_documento, numero_documento, nombre, direccion, telefono, email, session['user_id']))
        mysql.connection.commit()
        cur.close()
        flash('Cliente creado')
        return redirect(url_for('clientes'))
    return render_template('cliente_form.html', accion='Nuevo')

@app.route('/clientes/editar/<int:cliente_id>', methods=['GET','POST'])
@login_required
def editar_cliente(cliente_id):
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        tipo_documento = request.form.get('tipo_documento') or None
        numero_documento = request.form.get('numero_documento') or None
        nombre = request.form['nombre']
        direccion = request.form.get('direccion') or None
        telefono = request.form.get('telefono') or None
        email = request.form.get('email') or None
        cur.execute("""
            UPDATE cliente SET tipo_documento=%s, numero_documento=%s, nombre=%s, direccion=%s, telefono=%s, email=%s, created_by=%s
            WHERE cliente_id=%s
        """, (tipo_documento, numero_documento, nombre, direccion, telefono, email, session['user_id'], cliente_id))
        mysql.connection.commit()
        cur.close()
        flash('Cliente actualizado')
        return redirect(url_for('clientes'))
    cur.execute("SELECT * FROM cliente WHERE cliente_id=%s", (cliente_id,))
    cliente = cur.fetchone()
    cur.close()
    return render_template('cliente_form.html', accion='Editar', cliente=cliente)

# ---------------- PRODUCTOS ----------------
@app.route('/productos')
@login_required
def productos():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT p.*, u.nombre as usuario
        FROM producto p
        LEFT JOIN usuario u ON p.created_by = u.usuario_id
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('productos.html', productos=data)

@app.route('/productos/nuevo', methods=['GET','POST'])
@login_required
def nuevo_producto():
    if request.method == 'POST':
        nombre = request.form['nombre']
        tipo = request.form['tipo']
        descripcion = request.form.get('descripcion') or None
        precio_venta = request.form.get('precio_venta') or 0
        stock = request.form.get('stock') or 0
        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO producto (nombre, tipo, descripcion, precio_venta, stock, created_by)
            VALUES (%s,%s,%s,%s,%s,%s)
        """, (nombre, tipo, descripcion, precio_venta, stock, session['user_id']))
        mysql.connection.commit()
        cur.close()
        flash('Producto creado')
        return redirect(url_for('productos'))
    return render_template('producto_form.html', accion='Nuevo')

@app.route('/productos/editar/<int:producto_id>', methods=['GET','POST'])
@login_required
def editar_producto(producto_id):
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        nombre = request.form['nombre']
        tipo = request.form['tipo']
        descripcion = request.form.get('descripcion') or None
        precio_venta = request.form.get('precio_venta') or 0
        stock = request.form.get('stock') or 0
        cur.execute("""
            UPDATE producto SET nombre=%s, tipo=%s, descripcion=%s, precio_venta=%s, stock=%s, created_by=%s
            WHERE producto_id=%s
        """, (nombre, tipo, descripcion, precio_venta, stock, session['user_id'], producto_id))
        mysql.connection.commit()
        cur.close()
        flash('Producto actualizado')
        return redirect(url_for('productos'))
    cur.execute("SELECT * FROM producto WHERE producto_id=%s", (producto_id,))
    producto = cur.fetchone()
    cur.close()
    return render_template('producto_form.html', accion='Editar', producto=producto)
# ---------------- CONSULTAS Y RECETAS ----------------
@app.route('/consultas')
@login_required
def consultas():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT con.*, c.nombre as cliente, u.nombre as usuario
        FROM consulta con
        LEFT JOIN cliente c ON con.cliente_id = c.cliente_id
        LEFT JOIN usuario u ON con.created_by = u.usuario_id
        ORDER BY con.fecha DESC
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('consultas.html', consultas=data)

# ---------------- DETALLE DE CONSULTA ----------------
@app.route('/consultas/<int:consulta_id>')
@login_required
def detalle_consulta(consulta_id):
    cur = mysql.connection.cursor()

    # 1. Obtener datos de la consulta
    cur.execute("""
        SELECT con.*, c.nombre AS cliente, u.nombre AS usuario
        FROM consulta con
        LEFT JOIN cliente c ON con.cliente_id = c.cliente_id
        LEFT JOIN usuario u ON con.created_by = u.usuario_id
        WHERE con.consulta_id = %s
    """, (consulta_id,))
    consulta = cur.fetchone()

    # 2. Obtener receta asociada (si existe)
    cur.execute("""
        SELECT * FROM receta WHERE consulta_id = %s
    """, (consulta_id,))
    receta = cur.fetchone()

    cur.close()

    return render_template('consulta_detalle.html', consulta=consulta, receta=receta)

@app.route('/consultas/nueva', methods=['GET','POST'])
@login_required
def nueva_consulta():
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        # --- Datos de la consulta ---
        cliente_id = request.form['cliente_id']
        observaciones = request.form.get('observaciones') or None
        precio = request.form.get('precio') or 30000

        # Insertar la consulta
        cur.execute("""
            INSERT INTO consulta (cliente_id, observaciones, created_by, precio)
            VALUES (%s,%s,%s,%s)
        """, (cliente_id, observaciones, session['user_id'], precio))
        mysql.connection.commit()

        consulta_id = cur.lastrowid  # ID de la consulta recién creada

        # --- Datos de la receta (si los campos no están vacíos) ---
        esfera_od = request.form.get('esfera_od') or None
        esfera_oi = request.form.get('esfera_oi') or None
        cilindro_od = request.form.get('cilindro_od') or None
        eje_od = request.form.get('eje_od') or None
        add_od = request.form.get('add_od') or None
        cilindro_oi = request.form.get('cilindro_oi') or None
        eje_oi = request.form.get('eje_oi') or None
        add_oi = request.form.get('add_oi') or None
        observaciones_receta = request.form.get('observaciones_receta') or None

        # Si se llenó al menos un campo de receta, la registramos
        if any([esfera_od, esfera_oi, cilindro_od, eje_od, add_od, cilindro_oi, eje_oi, add_oi]):
            cur.execute("""
                INSERT INTO receta (
                    consulta_id, esfera_od, esfera_oi, cilindro_od, eje_od, add_od,
                    cilindro_oi, eje_oi, add_oi, observaciones, created_by
                )
                VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
            """, (
                consulta_id, esfera_od, esfera_oi, cilindro_od, eje_od, add_od,
                cilindro_oi, eje_oi, add_oi, observaciones_receta, session['user_id']
            ))
            mysql.connection.commit()

        cur.close()
        flash('Consulta registrada correctamente')
        return redirect(url_for('consultas'))

    # --- GET: mostrar el formulario ---
    cur.execute("SELECT cliente_id, nombre FROM cliente")
    clientes = cur.fetchall()
    cur.close()
    return render_template('consulta_form.html', clientes=clientes)


@app.route('/recetas')
@login_required
def recetas():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT r.*, c.fecha as fecha_consulta, cli.nombre as cliente, u.nombre as usuario
        FROM receta r
        LEFT JOIN consulta c ON r.consulta_id = c.consulta_id
        LEFT JOIN cliente cli ON c.cliente_id = cli.cliente_id
        LEFT JOIN usuario u ON r.created_by = u.usuario_id
        ORDER BY r.fecha DESC
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('recetas.html', recetas=data)

@app.route('/recetas/nueva', methods=['GET','POST'])
@login_required
def nueva_receta():
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        consulta_id = request.form['consulta_id']
        esfera_od = request.form.get('esfera_od') or None
        esfera_oi = request.form.get('esfera_oi') or None
        cilindro_od = request.form.get('cilindro_od') or None
        eje_od = request.form.get('eje_od') or None
        add_od = request.form.get('add_od') or None
        cilindro_oi = request.form.get('cilindro_oi') or None
        eje_oi = request.form.get('eje_oi') or None
        add_oi = request.form.get('add_oi') or None
        observaciones = request.form.get('observaciones') or None
        cur.execute("""
            INSERT INTO receta (consulta_id, esfera_od, esfera_oi, cilindro_od, eje_od, add_od, cilindro_oi, eje_oi, add_oi, observaciones, created_by)
            VALUES (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)
        """, (consulta_id, esfera_od, esfera_oi, cilindro_od, eje_od, add_od, cilindro_oi, eje_oi, add_oi, observaciones, session['user_id']))
        mysql.connection.commit()
        cur.close()
        flash('Receta registrada')
        return redirect(url_for('recetas'))
    cur.execute("SELECT consulta_id, fecha FROM consulta ORDER BY fecha DESC")
    consultas = cur.fetchall()
    cur.close()
    return render_template('receta_form.html', consultas=consultas)

# ---------------- EDITAR RECETA ----------------
@app.route('/recetas/editar/<int:receta_id>', methods=['GET', 'POST'])
@login_required
def editar_receta(receta_id):
    cur = mysql.connection.cursor()

    # --- GET: obtener receta existente ---
    if request.method == 'GET':
        cur.execute("""
            SELECT r.*, c.consulta_id, cli.nombre AS cliente
            FROM receta r
            LEFT JOIN consulta c ON r.consulta_id = c.consulta_id
            LEFT JOIN cliente cli ON c.cliente_id = cli.cliente_id
            WHERE r.receta_id = %s
        """, (receta_id,))
        receta = cur.fetchone()
        cur.close()
        return render_template('receta_form.html', receta=receta, editar=True)

    # --- POST: guardar cambios ---
    if request.method == 'POST':
        esfera_od = request.form.get('esfera_od') or None
        esfera_oi = request.form.get('esfera_oi') or None
        cilindro_od = request.form.get('cilindro_od') or None
        eje_od = request.form.get('eje_od') or None
        add_od = request.form.get('add_od') or None
        cilindro_oi = request.form.get('cilindro_oi') or None
        eje_oi = request.form.get('eje_oi') or None
        add_oi = request.form.get('add_oi') or None
        observaciones = request.form.get('observaciones') or None

        cur.execute("""
            UPDATE receta SET 
                esfera_od=%s, esfera_oi=%s, cilindro_od=%s, eje_od=%s, add_od=%s,
                cilindro_oi=%s, eje_oi=%s, add_oi=%s, observaciones=%s
            WHERE receta_id=%s
        """, (esfera_od, esfera_oi, cilindro_od, eje_od, add_od,
              cilindro_oi, eje_oi, add_oi, observaciones, receta_id))
        mysql.connection.commit()
        cur.close()

        flash('Fórmula actualizada correctamente')
        return redirect(url_for('consultas'))


# pedidos y entregas se pueden implementar análogamente; dejo las queries base:
# INSERT INTO pedido (proveedor_id, producto_id, cantidad, estado, created_by) VALUES (...)
# INSERT INTO entrega (pedido_id, venta_id, cliente_id, estado, created_by) VALUES (...)

# ---------------- VENTAS ----------------
@app.route('/ventas')
@login_required
def ventas():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT v.*, c.nombre as cliente, u.nombre as usuario
        FROM venta v
        LEFT JOIN cliente c ON v.cliente_id = c.cliente_id
        LEFT JOIN usuario u ON v.created_by = u.usuario_id
        ORDER BY v.fecha DESC
    """)
    data = cur.fetchall()
    cur.close()
    return render_template('ventas.html', ventas=data)

@app.route('/ventas/nueva', methods=['GET','POST'])
@login_required
def nueva_venta():
    cur = mysql.connection.cursor()

    if request.method == 'POST':
        cliente_id = request.form.get('cliente_id') or None

        # Obtener todas las listas de productos y cantidades
        productos = request.form.getlist('producto_id[]')
        cantidades = request.form.getlist('cantidad[]')

        # Validación
        if not productos or len(productos) == 0:
            flash('Debe seleccionar al menos un producto.', 'danger')
            return redirect(url_for('nueva_venta'))

        total = 0
        detalles = []

        # Calcular total y preparar los detalles
        for producto_id, cantidad_str in zip(productos, cantidades):
            if not producto_id:
                continue
            cantidad = int(cantidad_str or 0)
            if cantidad <= 0:
                continue

            cur.execute("SELECT precio_venta FROM producto WHERE producto_id=%s", (producto_id,))
            p = cur.fetchone()
            if not p:
                continue
            precio_unit = p['precio_venta']
            subtotal = precio_unit * cantidad
            total += subtotal
            detalles.append((producto_id, cantidad, precio_unit, subtotal))

        if not detalles:
            flash('Debe agregar al menos un producto válido.', 'danger')
            cur.close()
            return redirect(url_for('nueva_venta'))

        # Registrar venta
        cur.execute("INSERT INTO venta (cliente_id, total, created_by) VALUES (%s,%s,%s)",
                    (cliente_id, total, session['user_id']))
        venta_id = cur.lastrowid

        # Insertar cada detalle
        for d in detalles:
            cur.execute("""
                INSERT INTO venta_detalle (venta_id, producto_id, cantidad, precio_unitario, subtotal)
                VALUES (%s,%s,%s,%s,%s)
            """, (venta_id, d[0], d[1], d[2], d[3]))

        mysql.connection.commit()
        cur.close()

        flash('Venta registrada correctamente.')
        return redirect(url_for('ventas'))

    # --- GET ---
    cur.execute("SELECT cliente_id, nombre FROM cliente")
    clientes = cur.fetchall()
    cur.execute("SELECT producto_id, nombre, stock, precio_venta FROM producto WHERE stock > 0")
    productos = cur.fetchall()
    cur.close()
    return render_template('venta_form.html', clientes=clientes, productos=productos)

# ---------------- DETALLE DE VENTA ----------------
@app.route('/ventas/<int:venta_id>')
@login_required
def detalle_venta(venta_id):
    cur = mysql.connection.cursor()

    # 1. Obtener datos generales de la venta
    cur.execute("""
        SELECT v.*, c.nombre AS cliente, u.nombre AS usuario
        FROM venta v
        LEFT JOIN cliente c ON v.cliente_id = c.cliente_id
        LEFT JOIN usuario u ON v.created_by = u.usuario_id
        WHERE v.venta_id = %s
    """, (venta_id,))
    venta = cur.fetchone()

    # 2. Obtener el detalle de los productos vendidos
    cur.execute("""
        SELECT p.nombre, vd.cantidad, vd.precio_unitario, vd.subtotal
        FROM venta_detalle vd
        INNER JOIN producto p ON vd.producto_id = p.producto_id
        WHERE vd.venta_id = %s
    """, (venta_id,))
    detalles = cur.fetchall()

    cur.close()
    return render_template('venta_detalle.html', venta=venta, detalles=detalles)

# ---------------- REPORTES ----------------
@app.route('/reportes')
@login_required
def reportes():
    cur = mysql.connection.cursor()

    # Totales simples
    cur.execute("SELECT COUNT(*) AS total_clientes FROM cliente")
    total_clientes = cur.fetchone()['total_clientes']

    cur.execute("SELECT COUNT(*) AS total_productos FROM producto")
    total_productos = cur.fetchone()['total_productos']

    cur.execute("SELECT COUNT(*) AS total_ventas FROM venta")
    total_ventas = cur.fetchone()['total_ventas']

    # Total de dinero vendido
    cur.execute("SELECT COALESCE(SUM(total), 0) AS monto_total FROM venta")
    monto_total = cur.fetchone()['monto_total']

    # Mejores productos vendidos
    cur.execute("""
        SELECT p.nombre, SUM(vd.cantidad) AS unidades
        FROM venta_detalle vd
        INNER JOIN producto p ON vd.producto_id = p.producto_id
        GROUP BY p.nombre
        ORDER BY unidades DESC
        LIMIT 5
    """)
    top_productos = cur.fetchall()

    # Consultas recientes
    cur.execute("""
        SELECT c.consulta_id, cli.nombre AS cliente, c.fecha, u.nombre AS usuario
        FROM consulta c
        LEFT JOIN cliente cli ON c.cliente_id = cli.cliente_id
        LEFT JOIN usuario u ON c.created_by = u.usuario_id
        ORDER BY c.fecha DESC
        LIMIT 5
    """)
    ultimas_consultas = cur.fetchall()

    cur.close()

    return render_template(
        'reportes.html',
        total_clientes=total_clientes,
        total_productos=total_productos,
        total_ventas=total_ventas,
        monto_total=monto_total,
        top_productos=top_productos,
        ultimas_consultas=ultimas_consultas
    )

# ---------------- PROVEEDORES ----------------
@app.route('/proveedores')
@login_required
def proveedores():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT p.*, u.nombre AS usuario
        FROM proveedor p
        LEFT JOIN usuario u ON p.created_by = u.usuario_id
    """)
    proveedores = cur.fetchall()
    cur.close()
    return render_template('proveedores.html', proveedores=proveedores)

@app.route('/proveedores/nuevo', methods=['GET','POST'])
@login_required
def nuevo_proveedor():
    if request.method == 'POST':
        nombre = request.form['nombre']
        telefono = request.form.get('telefono') or None
        email = request.form.get('email') or None
        direccion = request.form.get('direccion') or None

        cur = mysql.connection.cursor()
        cur.execute("""
            INSERT INTO proveedor (nombre, telefono, email, direccion, created_by)
            VALUES (%s,%s,%s,%s,%s)
        """, (nombre, telefono, email, direccion, session['user_id']))
        mysql.connection.commit()
        cur.close()
        flash('Proveedor creado correctamente')
        return redirect(url_for('proveedores'))
    return render_template('proveedor_form.html', accion='Nuevo')

# ---------------- PEDIDOS ----------------
@app.route('/pedidos')
@login_required
def pedidos():
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT 
            ped.pedido_id,
            ped.cantidad,
            ped.estado,
            ped.receta_id,
            c.nombre AS cliente_nombre,
            prov.nombre AS proveedor_nombre,
            prod.nombre AS producto_nombre,
            u.nombre AS usuario_nombre
        FROM pedido ped
        LEFT JOIN cliente c ON ped.cliente_id = c.cliente_id
        LEFT JOIN proveedor prov ON ped.proveedor_id = prov.proveedor_id
        LEFT JOIN producto prod ON ped.producto_id = prod.producto_id
        LEFT JOIN usuario u ON ped.created_by = u.usuario_id
        ORDER BY ped.pedido_id DESC
    """)
    pedidos = cur.fetchall()
    cur.close()
    return render_template('pedidos.html', pedidos=pedidos)

@app.route('/api/recetas_por_cliente/<int:cliente_id>')
@login_required
def recetas_por_cliente(cliente_id):
    cur = mysql.connection.cursor()
    cur.execute("""
        SELECT r.receta_id, r.receta_id AS id, r.fecha
        FROM receta r
        INNER JOIN consulta c ON r.consulta_id = c.consulta_id
        WHERE c.cliente_id = %s
        ORDER BY r.fecha DESC
    """, (cliente_id,))
    recetas = cur.fetchall()
    cur.close()
    return {'recetas': recetas}

@app.route('/pedidos/nuevo', methods=['GET', 'POST'])
@login_required
def nuevo_pedido():
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        cliente_id = request.form['cliente_id']
        receta_id = request.form.get('receta_id') or None
        proveedor_id = request.form['proveedor_id']
        producto_id = request.form['producto_id']
        cantidad = int(request.form['cantidad'])
        estado = request.form.get('estado') or 'SIN_SOLICITAR_A_LAB'

        cur.execute("""
            INSERT INTO pedido (cliente_id, receta_id, proveedor_id, producto_id, cantidad, estado, created_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """, (cliente_id, receta_id, proveedor_id, producto_id, cantidad, estado, session['user_id']))
        
        mysql.connection.commit()
        cur.close()
        flash('Pedido creado correctamente.')
        return redirect(url_for('pedidos'))

    # GET: cargar datos para los desplegables
    cur.execute("SELECT cliente_id, nombre FROM cliente")
    clientes = cur.fetchall()
    cur.execute("SELECT receta_id, receta_id AS id FROM receta")
    recetas = cur.fetchall()
    cur.execute("SELECT proveedor_id, nombre FROM proveedor")
    proveedores = cur.fetchall()
    cur.execute("SELECT producto_id, nombre FROM producto")
    productos = cur.fetchall()
    cur.close()
    
    return render_template(
        'pedido_form.html',
        accion='Nuevo',
        clientes=clientes,
        recetas=recetas,
        proveedores=proveedores,
        productos=productos
    )

@app.route('/proveedores/editar/<int:proveedor_id>', methods=['GET', 'POST'])
def editar_proveedor(proveedor_id):
    cur = mysql.connection.cursor()
    cur.execute("SELECT * FROM proveedor WHERE proveedor_id = %s", (proveedor_id,))
    proveedor = cur.fetchone()

    if not proveedor:
        flash('Proveedor no encontrado', 'danger')
        return redirect(url_for('proveedores'))

    if request.method == 'POST':
        nombre = request.form['nombre']
        telefono = request.form['telefono']
        email = request.form['email']
        direccion = request.form['direccion']

        # Validaciones
        if not nombre.strip():
            flash('El nombre no puede estar vacío.', 'danger')
            return redirect(request.url)

        if telefono and not telefono.isdigit():
            flash('El teléfono solo puede contener números.', 'danger')
            return redirect(request.url)

        cur.execute("""
            UPDATE proveedor
            SET nombre = %s, telefono = %s, email = %s, direccion = %s
            WHERE proveedor_id = %s
        """, (nombre, telefono, email, direccion, proveedor_id))
        mysql.connection.commit()
        cur.close()

        flash('Proveedor actualizado correctamente', 'success')
        return redirect(url_for('proveedores'))

    cur.close()
    return render_template('proveedor_form.html', accion='Editar', proveedor=proveedor)


@app.route('/pedidos/editar/<int:pedido_id>', methods=['GET', 'POST'])
@login_required
def editar_pedido(pedido_id):
    cur = mysql.connection.cursor()
    if request.method == 'POST':
        cliente_id = request.form['cliente_id']
        receta_id = request.form.get('receta_id') or None
        proveedor_id = request.form['proveedor_id']
        producto_id = request.form['producto_id']
        cantidad = int(request.form['cantidad'])
        estado = request.form['estado']

        cur.execute("""
    UPDATE pedido
    SET proveedor_id=%s, producto_id=%s, estado=%s
    WHERE pedido_id=%s
""", (proveedor_id, producto_id, estado, pedido_id))

        mysql.connection.commit()
        cur.close()
        flash('Pedido actualizado correctamente.')
        return redirect(url_for('pedidos'))

    # GET: obtener el pedido existente y listas
    cur.execute("SELECT * FROM pedido WHERE pedido_id=%s", (pedido_id,))
    pedido = cur.fetchone()
    cur.execute("SELECT cliente_id, nombre FROM cliente")
    clientes = cur.fetchall()
    cur.execute("SELECT receta_id, receta_id AS id FROM receta")
    recetas = cur.fetchall()
    cur.execute("SELECT proveedor_id, nombre FROM proveedor")
    proveedores = cur.fetchall()
    cur.execute("SELECT producto_id, nombre FROM producto")
    productos = cur.fetchall()
    cur.close()
    
    return render_template(
        'pedido_form.html',
        accion='Editar',
        pedido=pedido,
        clientes=clientes,
        recetas=recetas,
        proveedores=proveedores,
        productos=productos
    )


if __name__ == '__main__':
    app.secret_key = app.config['SECRET_KEY']
    app.run(debug=True, host='0.0.0.0')