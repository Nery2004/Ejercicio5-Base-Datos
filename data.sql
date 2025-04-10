-- Garantias
INSERT INTO garantias (duracion, estado, condiciones) VALUES 
  (3,  'Activa', 'Garantía limitada de 3 meses'),
  (6,  'Activa', 'Garantía limitada de 6 meses'),
  (12, 'Activa', 'Garantía de 12 meses por defectos de fábrica'),
  (0,  'Activa', 'Sin garantía');


-- Productos
INSERT INTO productos (producto, garantia_id, precio_unitario, cantidad) VALUES
('Mouse inalámbrico Logitech',    2, 25.99, 50),
('Teclado mecánico Redragon',     3, 45.00, 30),
('Cargador USB-C 20W',            2, 15.50, 100),
('Audífonos Bluetooth Sony',      3, 85.75, 40),
('Power bank 10000mAh',           3, 35.00, 60),
('Webcam HD 1080p',               3, 49.99, 25),
('Cable HDMI 2.0 - 2m',           1,  9.99, 150),
('Soporte para laptop',           2, 29.00, 40),
('Hub USB 4 puertos',             1, 22.00, 70),
('Limpieza y mantenimiento de laptop', 4, 50.00, 999),
('Cambio de pasta térmica',       4, 25.00, 999),
('Adaptador Bluetooth USB',       2, 12.50, 80),
('Protector de pantalla 15.6"',   1, 10.00, 90),
('Base refrigerante para laptop', 2, 27.50, 35),
('Lámpara LED USB',               1,  5.75, 200);

-- Usuarios
INSERT INTO usuarios (nombre, correo, telefono) VALUES
('Carlos Méndez', 'carlos.mendez@mail.com', '555-1234'),
('Ana López', 'ana.lopez@mail.com', '555-5678'),
('Luis Rodríguez', 'luis.rod@mail.com', '555-9101'),
('María Pérez', 'maria.pz@mail.com', '555-1122'),
('José Martínez', 'jose.mtz@mail.com', '555-3344'),
('Andrea González', 'andrea.g@mail.com', '555-5566'),
('Daniel Herrera', 'daniel.hr@mail.com', '555-7788'),
('Gabriela Cruz', 'gab.cruz@mail.com', '555-9900'),
('Ricardo Ramírez', 'ricardo.rm@mail.com', '555-1212'),
('Fernanda Díaz', 'fer.diaz@mail.com', '555-3434');

-- Estados de pedidos
INSERT INTO estados (nombre_estado) VALUES
('Pendiente'),
('Pagado'),
('Enviado'),
('Entregado'),
('Cancelado');

-- ======================================
--  30 INSERTS en "pedidos" + detalles
-- ======================================

-- Pedido 1
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (1, 'Tarjeta de Crédito', 1, 86.49);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES 
(1, 1, 1, 25.99),  -- Mouse
(1, 2, 1, 45.00),  -- Teclado
(1, 3, 1, 15.50);  -- Cargador

-- Pedido 2
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (2, 'PayPal', 2, 170.74);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES 
(2, 4, 1, 85.75),  -- Audífonos
(2, 5, 1, 35.00),  -- Power bank
(2, 6, 1, 49.99);  -- Webcam

-- Pedido 3
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (3, 'Efectivo', 3, 60.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(3, 7, 1, 9.99),   -- Cable HDMI
(3, 8, 1, 29.00),  -- Soporte laptop
(3, 9, 1, 22.00);  -- Hub USB

-- Pedido 4
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (4, 'Tarjeta de Crédito', 4, 87.50);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(4, 10, 1, 50.00), -- Limpieza y mantenimiento
(4, 11, 1, 25.00), -- Cambio pasta térmica
(4, 12, 1, 12.50); -- Adaptador Bluetooth

-- Pedido 5
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (5, 'PayPal', 5, 80.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(5, 1, 1, 25.99),  -- Mouse
(5, 2, 1, 45.00),  -- Teclado
(5, 13, 1, 10.00); -- Protector pantalla

-- Pedido 6
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (6, 'Tarjeta de Crédito', 1, 43.24);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(6, 14, 1, 27.50), -- Base refrigerante
(6, 15, 1, 5.75),  -- Lámpara LED USB
(6, 7, 1, 9.99);   -- Cable HDMI

-- Pedido 7
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (7, 'PayPal', 2, 86.49);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(7, 1, 1, 25.99),  -- Mouse
(7, 3, 1, 15.50),  -- Cargador
(7, 2, 1, 45.00);  -- Teclado

-- Pedido 8
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (8, 'Efectivo', 3, 157.74);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(8, 4, 1, 85.75),  -- Audífonos
(8, 6, 1, 49.99),  -- Webcam
(8, 9, 1, 22.00);  -- Hub USB

-- Pedido 9
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (9, 'Tarjeta de Crédito', 4, 89.00);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(9, 8, 1, 29.00),  -- Soporte laptop
(9, 5, 1, 35.00),  -- Power bank
(9, 11, 1, 25.00); -- Cambio pasta térmica

-- Pedido 10
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (10, 'PayPal', 5, 104.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(10, 2, 1, 45.00),  -- Teclado
(10, 7, 1, 9.99),   -- Cable HDMI
(10, 10, 1, 50.00); -- Limpieza y mantenimiento

-- Pedido 11
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (1, 'Efectivo', 1, 100.49);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(11, 6, 1, 49.99),  -- Webcam
(11, 3, 1, 15.50),  -- Cargador
(11, 5, 1, 35.00);  -- Power bank

-- Pedido 12
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (2, 'Tarjeta de Crédito', 2, 79.50);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(12, 9, 1, 22.00),  -- Hub USB
(12, 2, 1, 45.00),  -- Teclado
(12, 12, 1, 12.50); -- Adaptador Bluetooth

-- Pedido 13
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (3, 'PayPal', 3, 43.25);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(13, 14, 1, 27.50), -- Base refrigerante
(13, 15, 1, 5.75),  -- Lámpara LED USB
(13, 13, 1, 10.00); -- Protector pantalla

-- Pedido 14
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (4, 'Efectivo', 4, 84.98);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(14, 11, 1, 25.00), -- Cambio pasta térmica
(14, 6, 1, 49.99),  -- Webcam
(14, 7, 1, 9.99);   -- Cable HDMI

-- Pedido 15
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (5, 'Tarjeta de Crédito', 5, 135.25);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(15, 4, 1, 85.75),  -- Audífonos
(15, 9, 1, 22.00),  -- Hub USB
(15, 14, 1, 27.50); -- Base refrigerante

-- Pedido 16
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (6, 'PayPal', 1, 92.50);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(16, 5, 1, 35.00),  -- Power bank
(16, 12, 1, 12.50), -- Adaptador Bluetooth
(16, 2, 1, 45.00);  -- Teclado

-- Pedido 17
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (7, 'Efectivo', 2, 91.50);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(17, 8, 1, 29.00),  -- Soporte laptop
(17, 5, 1, 35.00),  -- Power bank
(17, 14, 1, 27.50); -- Base refrigerante

-- Pedido 18
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (8, 'Tarjeta de Crédito', 3, 70.50);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(18, 3, 1, 15.50),  -- Cargador
(18, 13, 1, 10.00), -- Protector pantalla
(18, 2, 1, 45.00);  -- Teclado

-- Pedido 19
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (9, 'PayPal', 4, 65.73);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(19, 6, 1, 49.99),  -- Webcam
(19, 7, 1, 9.99),   -- Cable HDMI
(19, 15, 1, 5.75);  -- Lámpara USB

-- Pedido 20
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (10, 'Efectivo', 5, 110.00);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(20, 10, 1, 50.00), -- Limpieza y mantenimiento
(20, 11, 1, 25.00), -- Cambio pasta térmica
(20, 5, 1, 35.00);  -- Power bank

-- Pedido 21
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (1, 'Tarjeta de Crédito', 1, 83.24);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(21, 6, 1, 49.99),  -- Webcam
(21, 14, 1, 27.50), -- Base refrigerante
(21, 15, 1, 5.75);  -- Lámpara USB

-- Pedido 22
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (2, 'PayPal', 2, 32.49);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(22, 7, 1, 9.99),   -- Cable HDMI
(22, 13, 1, 10.00), -- Protector pantalla
(22, 12, 1, 12.50); -- Adaptador Bluetooth

-- Pedido 23
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (3, 'Efectivo', 3, 66.25);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(23, 2, 1, 45.00),  -- Teclado
(23, 3, 1, 15.50),  -- Cargador
(23, 15, 1, 5.75);  -- Lámpara USB

-- Pedido 24
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (4, 'Tarjeta de Crédito', 4, 124.74);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(24, 8, 1, 29.00),  -- Soporte laptop
(24, 7, 1, 9.99),   -- Cable HDMI
(24, 4, 1, 85.75);  -- Audífonos

-- Pedido 25
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (5, 'PayPal', 5, 109.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(25, 5, 1, 35.00),  -- Power bank
(25, 6, 1, 49.99),  -- Webcam
(25, 11, 1, 25.00); -- Cambio pasta térmica

-- Pedido 26
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (6, 'Efectivo', 1, 59.49);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(26, 9, 1, 22.00),  -- Hub USB
(26, 7, 1, 9.99),   -- Cable HDMI
(26, 14, 1, 27.50); -- Base refrigerante

-- Pedido 27
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (7, 'Tarjeta de Crédito', 2, 130.00);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(27, 2, 1, 45.00),  -- Teclado
(27, 10, 1, 50.00), -- Limpieza y mantenimiento
(27, 5, 1, 35.00);  -- Power bank

-- Pedido 28
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (8, 'PayPal', 3, 53.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(28, 1, 1, 25.99),  -- Mouse
(28, 3, 1, 15.50),  -- Cargador
(28, 12, 1, 12.50); -- Adaptador Bluetooth

-- Pedido 29
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (9, 'Efectivo', 4, 65.74);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(29, 6, 1, 49.99),  -- Webcam
(29, 15, 1, 5.75),  -- Lámpara USB
(29, 13, 1, 10.00); -- Protector pantalla

-- Pedido 30
INSERT INTO pedidos (usuario_id, metodo_pago, estado_id, sub_total)
VALUES (10, 'Tarjeta de Crédito', 5, 79.99);

INSERT INTO pedidos_detalle (pedido_id, producto_id, cantidad, precio_total)
VALUES
(30, 2, 1, 45.00),  -- Teclado
(30, 7, 1, 9.99),   -- Cable HDMI
(30, 11, 1, 25.00); -- Cambio pasta térmica
