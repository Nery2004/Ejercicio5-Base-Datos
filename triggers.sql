/*******************************************************
                TRIGGERS Y FUNCIONES COMPLETOS
            (Con comentarios y justificación final)
 *******************************************************/

/*=====================================================
    1) AFTER UPDATE en "productos" (log_productos_update)
    - Función: log_after_update_func()
    - Trigger: log_productos_update
 =====================================================*/

/* 
   Esta función registra en "logs" los datos OLD y NEW 
   cada vez que se hace un UPDATE a la tabla "productos".
   Incluye un RAISE NOTICE para verificar que se ejecute.
*/
CREATE OR REPLACE FUNCTION log_after_update_func()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'AFTER UPDATE TRIGGER (log_productos_update) FIRED ON TABLE %: OLD.id=% => NEW.id=%',
    TG_TABLE_NAME, OLD.id, NEW.id;

    INSERT INTO logs (
        table_name, operation, trigger_time, old_data, new_data
    )
    VALUES (
        TG_TABLE_NAME, 
        TG_OP, 
        'AFTER',
        to_jsonb(OLD),
        to_jsonb(NEW)
    );
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Llevar un registro completo de los cambios (UPDATE) en "productos".
  Tipo de operación y justificación:
    - AFTER UPDATE: Necesitamos que el registro se guarde tras confirmar el UPDATE.
      Asi capturamos el estado final (NEW) y el previo (OLD).
  Alternativa:
    - BEFORE UPDATE: Tal vez si se necesitara cambiar campos en la fila antes de grabar
      o abortar la operación, pero aquí solamente registramos datos ya definitivos.
*/
CREATE TRIGGER log_productos_update
AFTER UPDATE ON productos
FOR EACH ROW
EXECUTE FUNCTION log_after_update_func();

/*=====================================================
    2) AFTER DELETE en "usuarios" (log_usuarios_delete)
    - Función: log_after_delete_func()
    - Trigger: log_usuarios_delete
 =====================================================*/

/* 
   Registra en "logs" los datos del usuario que se borra 
   (AFTER DELETE) en la tabla "usuarios".
*/
CREATE OR REPLACE FUNCTION log_after_delete_func()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'AFTER DELETE TRIGGER (log_usuarios_delete) FIRED ON TABLE %, OLD ID=%',
    TG_TABLE_NAME, OLD.usuario_id;

    INSERT INTO logs (
        table_name, operation, trigger_time, old_data
    )
    VALUES (
        TG_TABLE_NAME,
        TG_OP,
        'AFTER',
        to_jsonb(OLD)
    );
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Llevar un historial de los usuarios que se eliminan.
  Tipo de operación y justificación:
    - AFTER DELETE: Queremos registrar la fila ya eliminada,
      de modo que confirmamos la operación y guardamos el OLD.
  Alternativa:
    - BEFORE DELETE: Nos serviría para evitar la eliminación si no cumple
      ciertos requisitos, pero en este caso necesitamos como 
      la certeza de que se borró y registrar el suceso.
*/
CREATE TRIGGER log_usuarios_delete
AFTER DELETE ON usuarios
FOR EACH ROW
EXECUTE FUNCTION log_after_delete_func();

/*=====================================================
    3) BEFORE INSERT en "pedidos" (validar_pedido_insert)
    - Función: validar_pedido_insert_func()
    - Trigger: validar_pedido_insert
 =====================================================*/

/* 
   Esta verifica que usuario y estado existan, y que sub_total > 0
   antes de permitir el INSERT en "pedidos". 
*/
CREATE OR REPLACE FUNCTION validar_pedido_insert_func()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'BEFORE INSERT TRIGGER (validar_pedido_insert) FIRED FOR pedido con ID que será=%', NEW.id;

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

/*
  Proposito: Validar la integridad de un nuevo registro en "pedidos".
  Tipo de operación y justificación:
    - BEFORE INSERT: Se desea impedir el INSERT si no cumple con las condiciones,
      por lo que debe hacerse antes de escribir la fila en la tabla.
  Alternativa:
    - AFTER INSERT: Sería tarde para impedir el registro, 
      se podria usar para logs, pero pues, esto no abortaria la operación.
*/
CREATE TRIGGER validar_pedido_insert
BEFORE INSERT ON pedidos
FOR EACH ROW
EXECUTE FUNCTION validar_pedido_insert_func();

/*=====================================================
    4) BEFORE TRUNCATE en "garantias" (prevenir_truncate_garantias)
    - Función: prevenir_truncate_garantias_func()
    - Trigger: prevenir_truncate_garantias
 =====================================================*/

/* 
   Bloquea el TRUNCATE de "garantias" si hay productos referenciandolas. 
*/
CREATE OR REPLACE FUNCTION prevenir_truncate_garantias_func()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'BEFORE TRUNCATE TRIGGER (prevenir_truncate_garantias) FIRED FOR "garantias"';

    IF EXISTS (SELECT 1 FROM productos WHERE garantia_id IS NOT NULL LIMIT 1) THEN
        RAISE EXCEPTION 'No se puede truncar la tabla garantias porque hay productos que dependen de ella';
    END IF;

    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Evitar que alguien borre (con TRUNCATE) toda la info. de garantias
        si aun hay productos que las usan.
  Tipo de operación y justificación:
    - BEFORE TRUNCATE: Se revisan dependencias antes de hacer
      la operación de truncarse la tabla.
  Alternativa:
    - AFTER TRUNCATE: Esto no va a impedir que suceda, pero tal vez
    podriamos tener un log para al menos saber que se dio un truncate y ver quien estuvo
    tocando mal la db en esa fecha. 
    Debemos abortar si hay dependencias, así que BEFORE es clave.
*/
CREATE TRIGGER prevenir_truncate_garantias
BEFORE TRUNCATE ON garantias
FOR EACH STATEMENT
EXECUTE FUNCTION prevenir_truncate_garantias_func();

/*=====================================================
    5) BEFORE UPDATE en "productos" (trigger_before_update_productos)
    - Función: before_update()
    - Trigger: trigger_before_update_productos
 =====================================================*/

/* 
   Actualiza "actualizado_en" y crea un log con OLD y NEW 
   justo antes de aplicar el UPDATE.
*/
CREATE OR REPLACE FUNCTION before_update()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'BEFORE UPDATE TRIGGER (trigger_before_update_productos) FIRED ON TABLE %, OLD ID=%',
    TG_TABLE_NAME, OLD.id;

    -- Registramos en logs
    INSERT INTO logs (table_name, operation, trigger_time, old_data, new_data, changed_at) VALUES 
    (TG_TABLE_NAME,TG_OP,'BEFORE',to_jsonb(OLD),to_jsonb(NEW),CURRENT_TIMESTAMP);
    
    RETURN NEW; 
END;
$$ LANGUAGE plpgsql;

/*
  Propósito:
    - Ver los cambios en "productos" justo antes de que se aplique el UPDATE,
      registrando los valores previos (OLD) y los nuevos (NEW).
  Tipo de operación y justificación:
    - BEFORE UPDATE: Se dispara antes de que la actualización se confirme, por que
      asi capturamos los valores de NEW, los cuales si 
      en algun momento se quisiera, podriamos modificar. Todo antes de la operación. También 
      permite la posibilidad de abortar el UPDATE si algo no cumple.
  Alternativa:
    - AFTER UPDATE: Registraría los datos definitivos, pero no nos permitiría
      alterar NEW si quisieramos ni detener la operación una vez concluida. 
*/
CREATE TRIGGER trigger_before_update_productos
BEFORE UPDATE ON productos
FOR EACH ROW
EXECUTE FUNCTION before_update();

/*=====================================================
    6) BEFORE DELETE en "productos" (trigger_before_delete_productos)
    - Función: before_delete()
    - Trigger: trigger_before_delete_productos
 =====================================================*/

/* 
   Registra en "logs" la fila que se va a borrar en "productos" 
   antes de eliminarla de una vez por todas.
*/
CREATE OR REPLACE FUNCTION before_delete()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'BEFORE DELETE TRIGGER (trigger_before_delete_productos) FIRED ON TABLE %, OLD ID=%',
    TG_TABLE_NAME, OLD.id;

    INSERT INTO logs (table_name, operation, trigger_time, old_data, changed_at) VALUES 
    (TG_TABLE_NAME,TG_OP,'BEFORE',to_jsonb(OLD),CURRENT_TIMESTAMP);
    
    RETURN OLD;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Capturar información en logs antes de perder la fila definitivamente.
  Tipo de operación y justificación:
    - BEFORE DELETE: Permite guardar o validar datos de la fila
      antes de su eliminación, en este caso pues lo guardamos en logs.
  Alternativa:
    - AFTER DELETE: Sería posible para sólo auditar la acción;
      sin embargo, no se podría abortar y no es tan útil si quisiéramos 
      alguna lógica previa a la eliminación.
*/
CREATE TRIGGER trigger_before_delete_productos
BEFORE DELETE ON productos
FOR EACH ROW
EXECUTE FUNCTION before_delete();

/*=====================================================
    7) AFTER INSERT en "productos" (trigger_after_insert_productos)
    - Función: after_insert()
    - Trigger: trigger_after_insert_productos
 =====================================================*/

/* 
   Una vez insertado un nuevo producto, registramos el "NEW" en logs.
*/
CREATE OR REPLACE FUNCTION after_insert()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'AFTER INSERT TRIGGER (trigger_after_insert_productos) FIRED ON TABLE %, NEW ID=%',
    TG_TABLE_NAME, NEW.id;

    INSERT INTO logs (table_name, operation, trigger_time, new_data, changed_at) VALUES 
    (TG_TABLE_NAME,TG_OP,'AFTER',to_jsonb(NEW),CURRENT_TIMESTAMP);
    
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Auditar la inserción de nuevas filas en "productos",
             guardando los datos recién agregados.
  Tipo de operación y justificación:
    - AFTER INSERT: Confirmamos que la fila ya se escribió en la db.
      Perfecto para logs y notificaciones.
  Alternativa:
    - BEFORE INSERT: Útil si quisiéramos ajustar datos en la fila 
      antes de guardarla, pero aquí sólo auditamos el registro final.
*/
CREATE TRIGGER trigger_after_insert_productos
AFTER INSERT ON productos
FOR EACH ROW
EXECUTE FUNCTION after_insert();

/*=====================================================
    8) AFTER TRUNCATE en "productos" (trigger_after_truncate_productos)
    - Función: after_truncate_productos()
    - Trigger: trigger_after_truncate_productos
 =====================================================*/

/* 
   Cuando se ejecute TRUNCATE sobre "productos", registramos ese evento en logs.
*/
CREATE OR REPLACE FUNCTION after_truncate()
RETURNS TRIGGER AS $$
BEGIN
    RAISE NOTICE 'AFTER TRUNCATE TRIGGER (trigger_after_truncate_productos) FIRED FOR TABLE %', TG_TABLE_NAME;

    INSERT INTO logs (table_name, operation, trigger_time, changed_at) VALUES 
    (TG_TABLE_NAME,'TRUNCATE','AFTER',CURRENT_TIMESTAMP);
    
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

/*
  Proposito: Auditar la operación de TRUNCATE sobre "productos"
             (que elimina todos los registros de una sola vez).
  Tipo de operación y justificación:
    - AFTER TRUNCATE: Se lanza después de la acción, 
      confirmando así que efectivamente se eliminaron todos los datos.
  Alternativa:
    - BEFORE TRUNCATE: PostgreSQL no ofrece nativamente un BEFORE TRUNCATE, 
      y además no tendría sentido si lo que se busca es registrar 
      que se completó la operación.
*/
CREATE TRIGGER trigger_after_truncate_productos
AFTER TRUNCATE ON productos
EXECUTE FUNCTION after_truncate_productos();