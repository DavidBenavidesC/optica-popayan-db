TYPE=TRIGGERS
triggers='CREATE DEFINER=`root`@`localhost` TRIGGER `trg_validar_detalle` BEFORE INSERT ON `venta_detalle` FOR EACH ROW BEGIN\n    IF NEW.producto_id IS NULL AND NEW.consulta_id IS NULL THEN\n        SIGNAL SQLSTATE \'45000\'\n        SET MESSAGE_TEXT = \'El detalle debe referenciar producto o consulta\';\n    END IF;\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER `trg_restar_stock` AFTER INSERT ON `venta_detalle` FOR EACH ROW BEGIN\n    IF NEW.producto_id IS NOT NULL THEN\n        UPDATE producto\n        SET stock = stock - NEW.cantidad\n        WHERE producto_id = NEW.producto_id;\n    END IF;\nEND' 'CREATE DEFINER=`root`@`localhost` TRIGGER `trg_devolver_stock` AFTER DELETE ON `venta_detalle` FOR EACH ROW BEGIN\n    IF OLD.producto_id IS NOT NULL THEN\n        UPDATE producto\n        SET stock = stock + OLD.cantidad\n        WHERE producto_id = OLD.producto_id;\n    END IF;\nEND'
sql_modes=524288 524288 524288
definers='root@localhost' 'root@localhost' 'root@localhost'
client_cs_names='utf8mb4' 'utf8mb4' 'utf8mb4'
connection_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci' 'utf8mb4_general_ci'
db_cl_names='utf8mb4_general_ci' 'utf8mb4_general_ci' 'utf8mb4_general_ci'
created=1761882175663648 1761882175648452 1761882175643271
