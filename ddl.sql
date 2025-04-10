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


-- Tabla: garantias
CREATE TABLE garantias (
    id SERIAL PRIMARY KEY,
    duracion INT CHECK(duracion >= 0),
    estado VARCHAR(20) NOT NULL CHECK (estado IN ('Activa', 'Expirada', 'Utilizada', 'Cancelada')),
    condiciones TEXT,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    actualizado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabla: productos
CREATE TABLE productos (
    id SERIAL PRIMARY KEY,
    producto VARCHAR(100) NOT NULL,
    garantia_id INT NOT NULL,
    precio_unitario DECIMAL(10,2) NOT NULL,
    cantidad INT NOT NULL DEFAULT 0,
    FOREIGN KEY (garantia_id) REFERENCES garantias(id) ON DELETE CASCADE
);

-- Tabla: pedidos
CREATE TABLE pedidos (
    id SERIAL PRIMARY KEY,
    usuario_id INT NOT NULL,
    metodo_pago VARCHAR(50) NOT NULL,
    estado_id INT NOT NULL,
    sub_total DECIMAL(10,2) NOT NULL,
    fecha_pedido TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (usuario_id) REFERENCES usuarios(usuario_id) ON DELETE CASCADE,
    FOREIGN KEY (estado_id) REFERENCES estados(estado_id) ON DELETE CASCADE 
);

-- Tabla: pedidos_detalle
CREATE TABLE pedidos_detalle (
    id SERIAL PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    UNIQUE (pedido_id, producto_id),
    FOREIGN KEY (pedido_id) REFERENCES pedidos(id) ON DELETE CASCADE,
    FOREIGN KEY (producto_id) REFERENCES productos(id) ON DELETE CASCADE
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