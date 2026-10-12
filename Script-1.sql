-- 0. Creación de la base de datos
create database retail_project;

-- 1. Creación de tablas
create table clientes (
	id_cliente INT generated always as identity primary key,
	email VARCHAR (200) not null unique check (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0)
);


CREATE TABLE ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL REFERENCES clientes(id_cliente),
    id_producto INT NOT NULL references productos(id_producto),
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0)
);


-- 2. Carga inicial de datos
SELECT COUNT(*) FROM public.clientes;

BEGIN;
INSERT INTO public.clientes (email)
VALUES
    ('ana.garcia@example.com'),
    ('bruno.fernandez@example.com'),
    ('carla.lopez@example.com'),
    ('diego.martin@example.com'),
    ('elena.suarez@example.com');
COMMIT;

SELECT id_cliente, email
FROM public.clientes
ORDER BY id_cliente;

SELECT COUNT(*) FROM public.productos;

BEGIN;
INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES
    ('Alimento adulto 3 kg', 'Alimento', 12900.00, 20),
    ('Alimento cachorro 3 kg', 'Alimento', 14500.00, 15),
    ('Collar ajustable', 'Accesorios', 7500.00, 10),
    ('Correa de nylon', 'Accesorios', 6200.00, 12),
    ('Pelota de goma', 'Juguetes', 3200.00, 25);
COMMIT;

SELECT id_producto, nombre, categoria, precio, stock
FROM public.productos
ORDER BY id_producto;

SELECT COUNT(*) FROM public.ventas;

SELECT id_cliente, email
FROM public.clientes
ORDER BY id_cliente;

SELECT id_producto, nombre
FROM public.productos
ORDER BY id_producto;

begin;
insert into public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
values
 	(1, 1, '2026-10-01', 2),
    (2, 2, '2026-10-02', 1),
    (3, 3, '2026-10-03', 3),
    (4, 4, '2026-10-04', 1),
    (5, 5, '2026-10-05', 2),
    (1, 5, '2026-10-06', 1);
COMMIT;

SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad
FROM public.ventas
ORDER BY id_venta;

-- 3. Eliminación del registro de prueba
SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad
FROM public.ventas
WHERE id_cliente = 1
  AND id_producto = 5
  AND fecha_venta = DATE '2026-10-06'
  AND cantidad = 1;

begin;
delete from public.ventas 
where id_venta = 6 
RETURNING id_venta, id_cliente, id_producto, fecha_venta, cantidad;
commit;

select count(*) as cantidad_de_ventas from public.ventas;


-- 4. Actualización de precios
select id_producto, nombre, categoria, precio
from public.productos
where categoria = 'Alimento'
order by id_producto;

begin;
update public.productos
set precio = round(precio * 1.10, 2)
where categoria = 'Alimento'
returning id_producto, nombre, precio;
commit;

-- 5. Verificaciones
SELECT
    (SELECT COUNT(*) FROM public.clientes) AS clientes,
    (SELECT COUNT(*) FROM public.productos) AS productos,
    (SELECT COUNT(*) FROM public.ventas) AS ventas;

