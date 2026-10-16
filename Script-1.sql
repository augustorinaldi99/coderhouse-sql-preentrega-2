-- PRE-ENTREGA 2: TABLAS, RESTRICCIONES Y DATOS INICIALES

-- FASE 0: ejecutar conectado a la base postgres.
CREATE DATABASE retail_project;

-- Luego, en DBeaver, conectarse a retail_project
-- y ejecutar desde la sección 1.


-- 1. CREACIÓN DE TABLAS

CREATE TABLE public.clientes (
    id_cliente INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    email VARCHAR(200) NOT NULL UNIQUE,
    CONSTRAINT chk_clientes_email
        CHECK (email ~* '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$')
);

CREATE TABLE public.productos (
    id_producto SERIAL PRIMARY KEY,
    nombre VARCHAR(200) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    precio DECIMAL(10,2) NOT NULL,
    stock INT NOT NULL,
    CONSTRAINT chk_productos_precio CHECK (precio > 0),
    CONSTRAINT chk_productos_stock CHECK (stock >= 0)
);

CREATE TABLE public.ventas (
    id_venta SERIAL PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_producto INT NOT NULL,
    fecha_venta DATE NOT NULL,
    cantidad INT NOT NULL,
    CONSTRAINT fk_ventas_cliente
        FOREIGN KEY (id_cliente) REFERENCES public.clientes(id_cliente),
    CONSTRAINT fk_ventas_producto
        FOREIGN KEY (id_producto) REFERENCES public.productos(id_producto),
    CONSTRAINT chk_ventas_cantidad CHECK (cantidad > 0)
);


-- 2. CARGA INICIAL DE DATOS
-- Cinco INSERT por tabla, dentro de una única transacción.

BEGIN;

INSERT INTO public.clientes (email)
VALUES ('ana.garcia@example.com');

INSERT INTO public.clientes (email)
VALUES ('bruno.fernandez@example.com');

INSERT INTO public.clientes (email)
VALUES ('carla.lopez@example.com');

INSERT INTO public.clientes (email)
VALUES ('diego.martin@example.com');

INSERT INTO public.clientes (email)
VALUES ('elena.suarez@example.com');


INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES ('Alimento adulto 3 kg', 'Alimento', 12900.00, 20);

INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES ('Alimento cachorro 3 kg', 'Alimento', 14500.00, 15);

INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES ('Collar ajustable', 'Accesorios', 7500.00, 10);

INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES ('Correa de nylon', 'Accesorios', 6200.00, 12);

INSERT INTO public.productos (nombre, categoria, precio, stock)
VALUES ('Pelota de goma', 'Juguetes', 3200.00, 25);


INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (1, 1, DATE '2026-10-01', 2);

INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (2, 2, DATE '2026-10-02', 1);

INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (3, 3, DATE '2026-10-03', 3);

INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (4, 4, DATE '2026-10-04', 1);

INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (5, 5, DATE '2026-10-05', 2);

-- Venta adicional de prueba que se eliminará en la sección 4.
INSERT INTO public.ventas (id_cliente, id_producto, fecha_venta, cantidad)
VALUES (1, 5, DATE '2026-10-06', 1);

COMMIT;


-- 3. VERIFICACIÓN DE LOS DATOS INSERTADOS

SELECT id_cliente, email
FROM public.clientes
ORDER BY id_cliente;

SELECT id_producto, nombre, categoria, precio, stock
FROM public.productos
ORDER BY id_producto;

SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad
FROM public.ventas
ORDER BY id_venta;

SELECT
    (SELECT COUNT(*) FROM public.clientes) AS cantidad_clientes,
    (SELECT COUNT(*) FROM public.productos) AS cantidad_productos,
    (SELECT COUNT(*) FROM public.ventas) AS cantidad_ventas;


-- 4. ELIMINACIÓN DE LA VENTA DE PRUEBA

-- Verificar el registro antes de eliminarlo.
SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad
FROM public.ventas
WHERE id_venta = 6;

BEGIN;

DELETE FROM public.ventas
WHERE id_venta = 6
RETURNING id_venta, id_cliente, id_producto, fecha_venta, cantidad;

COMMIT;


-- 5. ACTUALIZACIÓN DEL PRECIO POR CATEGORÍA
-- Aumenta un 10 % el precio de los productos de la categoría Alimento.
-- La subconsulta identifica los productos que se van a actualizar.

SELECT id_producto, nombre, categoria, precio
FROM public.productos
WHERE categoria = 'Alimento'
ORDER BY id_producto;

BEGIN;

UPDATE public.productos AS p
SET precio = ROUND(p.precio * 1.10, 2)
WHERE p.id_producto IN (
    SELECT id_producto
    FROM public.productos
    WHERE categoria = 'Alimento'
)
RETURNING p.id_producto, p.nombre, p.categoria, p.precio;

COMMIT;


-- 6. VERIFICACIÓN FINAL

SELECT
    (SELECT COUNT(*) FROM public.clientes) AS cantidad_clientes,
    (SELECT COUNT(*) FROM public.productos) AS cantidad_productos,
    (SELECT COUNT(*) FROM public.ventas) AS cantidad_ventas;

SELECT id_producto, nombre, categoria, precio, stock
FROM public.productos
ORDER BY id_producto;

SELECT id_venta, id_cliente, id_producto, fecha_venta, cantidad
FROM public.ventas
ORDER BY id_venta;
