-- Tabla: usuarios
CREATE TABLE usuarios (
    usuario_id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL, 
    telefono VARCHAR(20),
    direccion TEXT,
    fecha_registro TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: estados
CREATE TABLE estados (
    estado_id SERIAL PRIMARY KEY,
    nombre_estado VARCHAR(50) NOT NULL UNIQUE
);

-- Tabla: productos
CREATE TABLE productos (
    producto_id SERIAL PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL DEFAULT 0
);

-- Tabla: pedidos
CREATE TABLE pedidos (
    pedido_id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado_id INT NOT NULL,
    sub_total DECIMAL(10,2) NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id),
    FOREIGN KEY (estado_id) REFERENCES estados(estado_id)  
);

-- Tabla: pedidos_detalle
CREATE TABLE pedidos_detalle (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    UNIQUE (pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(pedido_id),
    FOREIGN KEY (producto_id) REFERENCES productos(producto_id)
);

-- Tabla: logs
CREATE TABLE IF NOT EXISTS logs (
  id SERIAL PRIMARY KEY,
  table_name TEXT NOT NULL,
  operation TEXT NOT NULL,
  trigger_time TEXT NOT NULL,
  old_data JSONB,
  new_data JSONB,
  changed_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: garantias
CREATE TABLE garantias (
    id SERIAL PRIMARY KEY,
    pedido_detalle_id INT NOT NULL REFERENCES pedidos_detalle(id) ON DELETE CASCADE,
    fecha_inicio DATE NOT NULL DEFAULT CURRENT_DATE,
    fecha_fin DATE NOT NULL,
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Activa', 'Expirada', 'Utilizada', 'Cancelada')),
    condiciones TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);