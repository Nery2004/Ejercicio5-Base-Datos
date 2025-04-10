-- Función para log AFTER UPDATE en productos
CREATE OR REPLACE FUNCTION log_productos_update_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logs (
        table_name, operation, trigger_time, old_data, new_data
    )
    VALUES (
        'productos', 'UPDATE', 'AFTER',
        jsonb_build_object(
            'id', OLD.id,
            'producto', OLD.producto,
            'garantia_id', OLD.garantia_id,
            'precio_unitario', OLD.precio_unitario,
            'cantidad', OLD.cantidad
        ),
        jsonb_build_object(
            'id', NEW.id,
            'producto', NEW.producto,
            'garantia_id', NEW.garantia_id,
            'precio_unitario', NEW.precio_unitario,
            'cantidad', NEW.cantidad
        )
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER log_productos_update
AFTER UPDATE ON productos
FOR EACH ROW
EXECUTE FUNCTION log_productos_update_func();
-- Función para log AFTER DELETE en usuarios
CREATE OR REPLACE FUNCTION log_usuarios_delete_func()
RETURNS TRIGGER AS $$
BEGIN
    INSERT INTO logs (
        table_name, operation, trigger_time, old_data
    )
    VALUES (
        'usuarios', 'DELETE', 'AFTER',
        jsonb_build_object(
            'usuario_id', OLD.usuario_id,
            'nombre', OLD.nombre,
            'correo', OLD.correo,
            'telefono', OLD.telefono,
            'direccion', OLD.direccion,
            'fecha_registro', OLD.fecha_registro
        )
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER log_usuarios_delete
AFTER DELETE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION log_usuarios_delete_func();
-- Función de validación BEFORE INSERT en pedidos
CREATE OR REPLACE FUNCTION validar_pedido_insert_func()
RETURNS TRIGGER AS $$
BEGIN
    -- Verificar que el usuario existe
    IF NOT EXISTS (SELECT 1 FROM usuarios WHERE usuario_id = NEW.usuario_id) THEN
        RAISE EXCEPTION 'Usuario con ID % no existe', NEW.usuario_id;
    END IF;

    -- Verificar que el estado existe
    IF NOT EXISTS (SELECT 1 FROM estados WHERE estado_id = NEW.estado_id) THEN
        RAISE EXCEPTION 'Estado con ID % no existe', NEW.estado_id;
    END IF;

    -- Verificar que el subtotal es positivo
    IF NEW.sub_total <= 0 THEN
        RAISE EXCEPTION 'El subtotal debe ser mayor que cero';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER validar_pedido_insert
BEFORE INSERT ON pedidos
FOR EACH ROW
EXECUTE FUNCTION validar_pedido_insert_func();
-- Función para prevenir truncado de garantias
CREATE OR REPLACE FUNCTION prevenir_truncate_garantias_func()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (SELECT 1 FROM productos WHERE garantia_id IS NOT NULL LIMIT 1) THEN
        RAISE EXCEPTION 'No se puede truncar la tabla garantias porque hay productos que dependen de ella';
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Trigger
CREATE TRIGGER prevenir_truncate_garantias
BEFORE TRUNCATE ON garantias
FOR EACH STATEMENT
EXECUTE FUNCTION prevenir_truncate_garantias_func();
