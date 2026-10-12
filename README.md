# Preentrega 2 — Retail Project

Ejercicio de creación de una base de datos de ventas en PostgreSQL.

## Archivos

- `Script-1.sql`: creación de la base y las tablas, carga de datos de ejemplo, actualización masiva de precios, eliminación de un registro de prueba y consultas de verificación.

## Modelo de datos

- `clientes`: identificador y correo electrónico único.
- `productos`: identificador, nombre, categoría, precio y stock.
- `ventas`: relaciona clientes y productos, e incluye fecha y cantidad.

El script define claves primarias, claves foráneas y restricciones `CHECK` para validar los datos.

## Cómo ejecutar el script en DBeaver

1. Conectarse a la base de mantenimiento `postgres` y ejecutar únicamente `CREATE DATABASE retail_project;` (si la base todavía no existe).
2. Conectarse a la base `retail_project`.
3. Ejecutar el resto de `Script-1.sql`, desde la sección `-- 1. Creación de tablas`.

PostgreSQL crea la base, pero no cambia automáticamente la conexión a ella. Por eso, la creación de tablas y las consultas restantes deben ejecutarse conectado a `retail_project`.

## Operaciones incluidas

- Inserción de cinco clientes y cinco productos con datos ficticios.
- Inserción de seis ventas y eliminación posterior de una venta de prueba, para conservar cinco registros.
- Aumento del 10 % en el precio de los productos de categoría `Alimento`, mediante un `UPDATE` con `WHERE`.
- Consultas para verificar los registros y la cantidad final de filas.

> El script está pensado para ejecutarse una sola vez sobre una base `retail_project` nueva y vacía. Si ya se ejecutó, no volver a correr los `INSERT`, el `UPDATE` ni el `DELETE`: los datos podrían duplicarse, los precios volverían a aumentar o la fila de prueba ya no existiría.

Los datos cargados son ficticios y se usan únicamente con fines educativos.
