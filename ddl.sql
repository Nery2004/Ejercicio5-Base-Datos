-- Tabla: usuarios
CREATE TABLE usuarios (
    id SERIAL PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    correo VARCHAR(100) UNIQUE NOT NULL,
    telefono VARCHAR(20)
);

-- Tabla: estados
CREATE TABLE estados (
    id SERIAL PRIMARY KEY,
    tipo VARCHAR(50) NOT NULL,
    estado VARCHAR(50) NOT NULL
);

-- Tabla: productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    precio_unitario NUMERIC(10, 2) NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad >= 0)
);

-- Tabla: pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL REFERENCES usuarios(id) ON DELETE CASCADE,
    metodo_pago VARCHAR(50),
    estado_id INT REFERENCES estados(id),
    sub_total NUMERIC(10, 2),
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: pedidos_detalle
CREATE TABLE pedidos_detalle (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL REFERENCES pedidos(id) ON DELETE CASCADE,
    producto_id INT NOT NULL REFERENCES productos(id),
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_total NUMERIC(10, 2) NOT NULL
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