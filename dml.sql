-- Países
INSERT INTO pais (nombre) VALUES 
    ('Estados Unidos'), ('Canadá'), ('México'), ('Brasil'), ('Argentina'), ('Chile'), ('España');

-- Regiones
INSERT INTO region (nombre, id_pais) VALUES 
    ('California', 1),
    ('Quebec', 2),
    ('Jalisco', 3),
    ('São Paulo', 4),
    ('Buenos Aires', 5),
    ('Santiago', 6),
    ('Comunidad de Madrid', 7);

-- Ciudades
INSERT INTO ciudad (nombre, id_region) VALUES 
    ('Los Angeles', 1),
    ('Montreal', 2),
    ('Guadalajara', 3),
    ('São Paulo', 4),
    ('Buenos Aires', 5),
    ('Santiago', 6),
    ('Madrid', 7);

-- Direcciones
INSERT INTO direccion (linea_direccion1, barrio, id_ciudad) VALUES 
    ('123 Hollywood Blvd', 'Hollywood', 1),
    ('456 Maple Street', 'Downtown', 2),
    ('789 Pine Ave', 'Centro', 3),
    ('1011 Banana Blvd', 'Market', 4),
    ('1213 Apple Ave', 'North Side', 5),
    ('1415 Orange Street', 'South Side', 6),
    ('Calle Gran Vía, 1', 'Centro', 7);

-- Gama de productos
INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html, imagen) VALUES 
    ('Electrónica', 'Dispositivos y gadgets electrónicos.', '<p>Dispositivos y gadgets electrónicos.</p>', 'electronica.jpg'),
    ('Hogar', 'Artículos para el hogar.', '<p>Artículos para el hogar.</p>', 'hogar.jpg'),
    ('Jardinería', 'Herramientas y decoraciones para jardín.', '<p>Herramientas y decoraciones para jardín.</p>', 'jardineria.jpg'),
    ('Deporte', 'Equipamiento deportivo.', '<p>Equipamiento deportivo.</p>', 'deporte.jpg'),
    ('Moda', 'Ropa y accesorios de moda.', '<p>Ropa y accesorios de moda.</p>', 'moda.jpg'),
    ('Juguetes', 'Juguetes para todas las edades.', '<p>Juguetes para todas las edades.</p>', 'juguetes.jpg');

-- Dimensiones
INSERT INTO dimensiones (id_dimensiones, ancho, alto, profundo) VALUES 
    ('D001', 30.00, 40.00, 15),
    ('D002', 50.00, 60.00, 20),
    ('D003', 10.00, 20.00, 5),
    ('D004', 100.00, 200.00, 50),
    ('D005', 5.00, 10.00, 2),
    ('D006', 120.00, 130.00, 100);

-- Productos
INSERT INTO producto (codigo_producto, nombre, id_gama, id_dimensiones, descripcion, cantidad_en_stock, precio_venta, precio_proveedor) VALUES 
    ('P001', 'Teléfono Inteligente', 'Electrónica', 'D001', 'Último modelo con cámara HD.', 100, 500.00, 300.00),
    ('P002', 'Laptop ProMax', 'Electrónica', 'D002', 'Alta capacidad y rendimiento.', 50, 1200.00, 800.00),
    ('P003', 'Blender Turbo', 'Hogar', 'D003', 'Licuadora de alta velocidad.', 150, 99.99, 60.00),
    ('P004', 'Set de Jardinería', 'Jardinería', 'D004', 'Todo lo necesario para el cuidado del jardín.', 200, 80.00, 40.00),
    ('P005', 'Pelota de Fútbol', 'Deporte', 'D005', 'Pelota oficial tamaño y peso.', 300, 25.00, 15.00),
    ('P006', 'Conjunto de Ropa', 'Moda', 'D006', 'Incluye camisa, pantalón y accesorios.', 150, 100.00, 50.00);

-- Contactos
INSERT INTO contacto (id_contacto, telefono, fax, nombre_contacto, apellido_contacto) VALUES 
    (1, '2345678901', '1098765432', 'José', 'Ramírez'),
    (2, '3456789012', '2109876543', 'Carlos', 'Gomez'),
    (3, '4567890123', '3210987654', 'Marie', 'Dupon'),
    (4, '5678901234', '4321098765', 'Luigi', 'Rossi'),
    (5, '6789012345', '5432109876', 'John', 'Smith'),
    (6, '7890123456', '6543210987', 'Sara', 'Johnson');

-- Oficinas
INSERT INTO oficina (nombre, telefono, id_direccion) VALUES 
    ('Oficina Central', '1234567890', 1),
    ('Oficina Regional', '2345678901', 2),
    ('Oficina Norte', '3456789012', 3),
    ('Oficina Sur', '4567890123', 4),
    ('Oficina Este', '5678901234', 5),
    ('Oficina_direccion Oeste', '6789012345', 6),
    ('Oficina Madrid', '910203040', 7);

-- Empleados
INSERT INTO empleado (codigo_empleado, nombre_empleado, apellido_empleado1, extension, email, codigo_oficina, codigo_jefe, puesto) VALUES 
    (1, 'Juan', 'Pérez', '1234', 'juan.perez@empresa.com', 1, 12, 'Gerente'),
    (2, 'Luisa', 'Martínez', '5678', 'luisa.martinez@empresa.com', 2, 123, 'Secretaria'),
    (3, 'Carlos', 'Gomez', '9012', 'carlos.gomez@empresa.com', 3, 1234 , 'Coordinador'),
    (4, 'María', 'Garcia', '3456', 'maria.garcia@empresa.com', 4), 12345, 'Directora',
    (5, 'Ana', 'Lopez', '7890', 'ana.lopez@empresa.com', 5, 123456, 'Asistente'),
    (6, 'Miguel', 'Hernández', '1234', 'miguel.hernandez@empresa.com', 6, 123456, 'Asistente'),
    (7, 'Andrés', 'Arenas', '3741', 'andres.arenas@empresa.com', 7, 7, 'Coordinador');

-- Clientes
INSERT INTO cliente (nombre_cliente, id_contacto, id_direccion, codigo_empleado, limite_credito) VALUES 
    ('Cliente 1', 1, 1, 1, 1000.00),
    ('Cliente 2', 2, 2, 2, 2000.00),
    ('Cliente 3', 3, 3, 3, 3000.00),
    ('Cliente 4', 4, 4, 4, 4000.00),
    ('Cliente 5', 5, 5, 5, 5000.00),
    ('Cliente 6', 6, 6, 6, 6000.00);

-- Pedidos
INSERT INTO pedido (codigo_pedido, fecha_pedido, fecha_esperada, estado, codigo_cliente) VALUES 
    (1001, '2024-04-21', '2024-04-28', 'Enviado', 1),
    (1002, '2024-04-21', '2024-04-28', 'Enviado', 2),
    (1003, '2024-04-22', '2024-04-29', 'Cancelado', 3),
    (1004, '2024-04-23', '2024-04-30', 'Pendiente', 4),
    (1005, '2024-04-24', '2024-05-01', 'Enviado', 5),
    (1006, '2024-04-25', '2024-05-02', 'Cancelado', 6);

-- Detalles de pedido
INSERT INTO detalle_pedido (codigo_pedido, codigo_producto, cantidad, precio_unidad, numero_linea) VALUES 
    (1001, 'P001', 2, 500.00, 1),
    (1002, 'P002', 1, 1200.00, 1),
    (1003, 'P003', 3, 99.99, 1),
    (1004, 'P004', 5, 80.00, 1),
    (1005, 'P005', 10, 25.00, 1),
    (1006, 'P006', 4, 100.00, 1);

-- Pagos
INSERT INTO pago (id_transaccion, codigo_cliente, forma_pago, fecha_pago, total) VALUES 
    ('T001', 1, 'Tarjeta de crédito', '2024-04-21', 1000.00),
    ('T002', 2, 'Efectivo', '2024-04-21', 1200.00),
    ('T003', 3, 'Tarjeta de crédito', '2024-04-22', 299.97),
    ('T004', 4, 'Efectivo', '2024-04-23', 400.00),
    ('T005', 5, 'Cheque', '2024-04-24', 250.00),
    ('T006', 6, 'Transferencia', '2024-04-25', 400.00);
