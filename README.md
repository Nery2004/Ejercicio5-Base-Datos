# Ejercicio5-Base-Datos - Tienda de Accesorios de Tecnología

Este proyecto consiste en el diseño e implementación de una base de datos relacional para una **tienda de accesorios de tecnología**, la cual vende gadgets, ofrece accesorios y servicios de mantenimiento de garantías. 

El sistema permite gestionar información sobre clientes, productos, pedidos, y sus respectivos detalles.

## Estructura de la base de datos

El modelo de datos está compuesto por las siguientes tablas:

- **usuarios**: Información de los clientes de la tienda.
- **productos**: Lista de artículos disponibles para la venta.
- **estados**: Estado de los pedidos (pendiente, enviado, entregado, etc.).
- **pedidos**: Encabezado de las órdenes realizadas por los clientes.
- **pedidos_detalle**: Detalles específicos de cada producto dentro de un pedido.

La estructura completa puede ser consultada en la hoja de cálculo adjunta:
👉 [Diseño de base de datos - Google Sheets](https://docs.google.com/spreadsheets/d/1V6sFgJkz6whZT5JlTDycmaax3VTbgPfyksvys2A496M/edit?gid=0#gid=0)

## Scripts disponibles

El proyecto incluye scripts SQL para:

- Crear la estructura de las tablas.
- Insertar datos de prueba (15 productos, 10 clientes, 30 pedidos y 90 detalles de pedido).
- Ejecutar consultas básicas.

## Documentación del ejercicio

Se incluye una descripción del ejercicio, objetivos y detalles técnicos en el siguiente documento:
📄 [Instrucciones del proyecto - Google Docs](https://docs.google.com/document/d/1ZRGgxNCBwG2-18GJmu6M3iQZnWQHmN1Z8Di0PNyn0Es/edit?tab=t.0#heading=h.g32erqn6e8mo)

## Tecnologías utilizadas

- PostgreSQL
- Docker (opcional para contenedor)
- SQL puro

## Cómo ejecutar

1. Crea la base de datos en PostgreSQL.
2. Ejecuta los scripts en el orden:
   - `create_tables.sql`
   - `insert_data.sql`
3. Realiza consultas de ejemplo o integra con una aplicación.

---

Autor: *[Tu nombre]*  
Universidad del Valle de Guatemala  
Curso: Ingeniería de Software / Bases de Datos

