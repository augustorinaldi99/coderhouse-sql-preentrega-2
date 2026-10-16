# Pre-entrega 2 — Tablas principales con restricciones y datos iniciales

Script SQL para crear la base `retail_project`, definir las tablas `clientes`, `productos` y `ventas`, cargar datos de ejemplo y realizar consultas de verificación, una actualización y una eliminación.

## Requisitos

- PostgreSQL instalado y en ejecución.
- DBeaver u otro cliente PostgreSQL.
- Un usuario con permisos para crear bases de datos.

## Ejecución en DBeaver

La creación de la base y la creación de las tablas se realizan en dos pasos, porque PostgreSQL no cambia automáticamente la conexión al ejecutar `CREATE DATABASE`.

1. Conectarse a una base existente, por ejemplo `postgres`.
2. En `Script-1.sql`, ejecutar únicamente `CREATE DATABASE retail_project;`.
   - Si la base ya existe, omitir este paso.
3. Conectarse a la base `retail_project`.
4. Ejecutar el resto de `Script-1.sql`, desde la sección **1. Creación de tablas**.

El script está pensado para ejecutarse sobre una base recién creada. No volver a ejecutarlo completo sobre una base que ya contiene las tablas y los datos, porque se intentarían crear e insertar nuevamente.

## Contenido del script

- Tablas con claves primarias y foráneas.
- Restricciones `CHECK` para validar los datos.
- Inserciones iniciales dentro de una transacción.
- Consultas de verificación.
- Actualización de precios por categoría.
- Eliminación de una venta de prueba.
