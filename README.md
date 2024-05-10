# Database 1

Creación de la primera base de datos del proyecto SQL

## **CONSULTAS**

1. Devuelve un listado con el código de oficina y la ciudad donde hay oficinas.
```sql
SELECT o.codigo_oficina, c.nombre AS ciudad
FROM oficina AS o
JOIN direccion d ON o.id_direccion = d.id_direccion
JOIN ciudad c ON d.id_ciudad = c.id_ciudad;

+----------------+--------------+
| codigo_oficina | ciudad       |
+----------------+--------------+
|              1 | Los Angeles  |
|              2 | Montreal     |
|              3 | Guadalajara  |
|              4 | São Paulo    |
|              5 | Buenos Aires |
|              6 | Santiago     |
+----------------+--------------+
```

2. Devuelve un listado con la ciudad y el teléfono de las oficinas de España.
```sql
SELECT o.nombre AS oficina, o.telefono, ci.nombre AS ciudad
FROM oficina AS o
JOIN direccion AS d ON o.id_direccion = d.id_direccion
JOIN ciudad AS ci ON d.id_ciudad = ci.id_ciudad
JOIN region AS r ON ci.id_region = r.id_region
JOIN pais AS p ON r.id_pais = p.id_pais
WHERE p.nombre = 'España';

+----------------+-----------+--------+
| oficina        | telefono  | ciudad |
+----------------+-----------+--------+
| Oficina Madrid | 910203040 | Madrid |
+----------------+-----------+--------+
```

3. Devuelve un listado con el nombre, apellidos y email de los empleados cuyo jefe tiene un código de jefe igual a 7.
```sql
SELECT nombre_empleado, apellido_empleado1, email
FROM empleado
WHERE codigo_jefe = 7;

+-----------------+--------------------+---------------------------+
| nombre_empleado | apellido_empleado1 | email                     |
+-----------------+--------------------+---------------------------+
| Andrés          | Arenas             | andres.arenas@empresa.com |
+-----------------+--------------------+---------------------------+
```

4. Devuelve el nombre del puesto, nombre, apellidos y email del jefe de la empresa.
```sql
SELECT e.nombre_empleado as nombre , e.apellido1_empleado as apellido1, e.apellido2_empleado as apellido2, e.puesto
FROM empleado AS e WHERE e.puesto = 'Gerente';
+--------+-----------+-----------+---------+
 | nombre | apellido1 | apellido2 | puesto  |
 +--------+-----------+-----------+---------+
 | Juan   | Pérez     | Null      | Gerente |
 +--------+-----------+-----------+---------+
```

5. Devuelve un listado con el nombre, apellidos y puesto de aquellos empleados que no sean representantes de ventas.
```sql
SELECT nombre_empleado, apellido_empleado1, puesto
FROM empleado
WHERE puesto != 'Representante de ventas';

+-----------------+--------------------+-------------+
| nombre_empleado | apellido_empleado1 | puesto      |
+-----------------+--------------------+-------------+
| Juan            | Pérez              | Gerente     |
| Luisa           | Martínez           | Secretaria  |
| Carlos          | Gomez              | Coordinador |
| María           | Garcia             | Directora   |
| Ana             | Lopez              | Asistente   |
| Miguel          | Hernández          | Asistente   |
| Andrés          | Arenas             | Coordinador |
+-----------------+--------------------+-------------+
```

6. Devuelve un listado con el nombre de los todos los clientes españoles.
```sql
SELECT nombre_cliente
FROM cliente AS cl
JOIN direccion d ON cl.id_direccion = d.id_direccion
JOIN ciudad c ON d.id_ciudad = c.id_ciudad
WHERE c.nombre LIKE '%España%' OR c.nombre LIKE '%Spain%';
```

7. Devuelve un listado con los distintos estados por los que puede pasar un pedido.
```sql
SELECT DISTINCT estado
FROM pedido;
+-----------+
| estado    |
+-----------+
| Enviado   |
| Cancelado |
| Pendiente |
+-----------+
```

8. Clientes que pagaron en 2008. Tres métodos.
```sql
-- Usando YEAR
SELECT DISTINCT codigo_cliente, nombre_cliente AS 'Nombre Cliente'
FROM cliente
WHERE codigo_cliente IN (SELECT codigo_cliente FROM pago WHERE YEAR(fecha_pago) = 2008);

-- Usando DATE_FORMAT
SELECT DISTINCT c.codigo_cliente, c.nombre_cliente AS 'Nombre Cliente'
FROM pago AS p
JOIN cliente AS c ON p.codigo_cliente = c.codigo_cliente
WHERE DATE_FORMAT(p.fecha_pago, '%Y') = '2008';

-- Sin usar funciones de fecha
SELECT DISTINCT c.codigo_cliente, c.nombre_cliente AS 'Nombre Cliente'
FROM pago AS p
JOIN cliente AS c ON p.codigo_cliente = c.codigo_cliente
WHERE p.fecha_pago BETWEEN '2008-01-01' AND '2008-12-31';

+----------------+----------------+
| codigo_cliente | Nombre Cliente |
+----------------+----------------+
|              7 | Cliente 7      |
+----------------+----------------+
```

9. Devuelve un listado con el código de pedido, código de cliente, fecha esperada y fecha de entrega de los pedidos que no han sido entregados a tiempo.
```sql
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega > fecha_esperada;
```

10. Pedidos entregados antes de tiempo.
```sql
-- Usando ADDDATE
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE fecha_entrega <= ADDDATE(fecha_esperada, INTERVAL -2 DAY);

-- Usando DATEDIFF
SELECT codigo_pedido, codigo_cliente, fecha_esperada, fecha_entrega
FROM pedido
WHERE DATEDIFF(fecha_esperada, fecha_entrega) >= 2;

-- Usando operadores
-- No es posible en *SQL estándar*; se debe usar una función.
```

11. Devuelve un listado de todos los pedidos que fueron rechazados en 2009.
```sql
SELECT *
FROM pedido
WHERE estado = 'Rechazado' AND YEAR(fecha_pedido) = 2009;
```

12. Devuelve un listado de todos los pedidos que han sido entregados en el mes de enero de cualquier año.
```sql
SELECT *
FROM pedido
WHERE MONTH(fecha_entrega) = 1;
```

13. Devuelve un listado con todos los pagos que se realizaron en el año 2008 mediante Paypal. Ordene el resultado de mayor a menor.
```sql
SELECT *
FROM pago
WHERE forma_pago = 'Paypal' AND YEAR(fecha_pago) = 2008
ORDER BY total DESC;
```

14. Devuelve un listado con todas las formas de pago que aparecen en la tabla pago. Tenga en cuenta que no deben aparecer formas de pago repetidas.
```sql
SELECT DISTINCT forma_pago
FROM pago;
+---------------------+
| forma_pago          |
+---------------------+
| Tarjeta de crédito  |
| Efectivo            |
| Cheque              |
| Transferencia       |
+---------------------+
```

15. Devuelve un listado con todos los productos que pertenecen a la gama Ornamentales y que tienen más de 100 unidades en stock. El listado deberá estar ordenado por su precio de venta, mostrando en primer lugar los de mayor precio.
```sql
SELECT *
FROM producto
WHERE id_gama = 'Ornamentales' AND cantidad_en_stock > 100
ORDER BY precio_venta DESC;
```

16. Devuelve un listado con todos los clientes que sean de la ciudad de Madrid y cuyo representante de ventas tenga el código de empleado 11 o 30.
```sql
SELECT nombre_cliente, apellido_contacto
FROM cliente
WHERE codigo_cliente IN (
SELECT codigo_cliente
FROM cliente_direccion
WHERE id_direccion IN (SELECT id_direccion FROM direccion WHERE 
id_ciudad IN (SELECT id_ciudad FROM ciudad WHERE nombre = 'Madrid'))
) AND codigo_empleado_rep_ventas IN (11, 30);
```

## **Consultas multitabla (composición interna)**

Resuelva todas las consultas utilizando la sintaxis de SQL1 y SQL2. Las consultas con sintaxis de SQL2 se deben resolver con INNER JOIN y NATURAL JOIN.

1. Obtén un listado con el nombre de cada cliente y el nombre y apellido de su representante de ventas.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado;

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado;


+----------------+-----------------+--------------------+
| nombre_cliente | nombre_empleado | apellido_empleado1 |
+----------------+-----------------+--------------------+
| Cliente 1      | Juan            | Pérez              |
| Cliente 2      | Luisa           | Martínez           |
| Cliente 3      | Carlos          | Gomez              |
| Cliente 4      | María           | Garcia             |
| Cliente 5      | Ana             | Lopez              |
| Cliente 6      | Miguel          | Hernández          |
+----------------+-----------------+--------------------+
```

2. Muestra el nombre de los clientes que hayan realizado pagos junto con el nombre de sus representantes de ventas.
```sql
--SQL1 
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c, empleado e, pago p
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
AND c.codigo_cliente = p.codigo_cliente;

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente;

+----------------+-----------------+--------------------+
| nombre_cliente | nombre_empleado | apellido_empleado1 |
+----------------+-----------------+--------------------+
| Cliente 1      | Juan            | Pérez              |
| Cliente 2      | Luisa           | Martínez           |
| Cliente 3      | Carlos          | Gomez              |
| Cliente 4      | María           | Garcia             |
| Cliente 5      | Ana             | Lopez              |
| Cliente 6      | Miguel          | Hernández          |
+----------------+-----------------+--------------------+
```
3. Muestra el nombre de los clientes que no hayan realizado pagos junto con el nombre de sus representantes de ventas.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c, empleado e
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
AND c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago);

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
WHERE p.codigo_cliente IS NULL;

```
4. Devuelve el nombre de los clientes que han hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c, empleado e, pago p, oficina_direccion o, direccion d
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
AND c.codigo_cliente = p.codigo_cliente
AND e.codigo_oficina = o.codigo_oficina
AND o.id_direccion = d.id_direccion;

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina_direccion o ON e.codigo_oficina = o.codigo_oficina
INNER JOIN direccion d ON o.id_direccion = d.id_direccion;

+----------------+-----------------+--------------------+-----------+
| nombre_cliente | nombre_empleado | apellido_empleado1 | id_ciudad |
+----------------+-----------------+--------------------+-----------+
| Cliente 1      | Juan            | Pérez              |         1 |
| Cliente 2      | Luisa           | Martínez           |         2 |
| Cliente 3      | Carlos          | Gomez              |         3 |
| Cliente 4      | María           | Garcia             |         4 |
| Cliente 5      | Ana             | Lopez              |         5 |
| Cliente 6      | Miguel          | Hernández          |         6 |
+----------------+-----------------+--------------------+-----------+
```
5. Devuelve el nombre de los clientes que no hayan hecho pagos y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c, empleado e, oficina_direccion o, direccion d
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
AND c.codigo_cliente NOT IN (SELECT codigo_cliente FROM pago)
AND e.codigo_oficina = o.codigo_oficina
AND o.id_direccion = d.id_direccion;

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
LEFT JOIN pago p ON c.codigo_cliente = p.codigo_cliente
INNER JOIN oficina_direccion o ON e.codigo_oficina = o.codigo_oficina
INNER JOIN direccion d ON o.id_direccion = d.id_direccion
WHERE p.codigo_cliente IS NULL;

```
6. Lista la dirección de las oficinas que tengan clientes en Fuenlabrada.
```sql
--SQL1
SELECT DISTINCT d.*
FROM direccion d, cliente c, ciudad ci
WHERE d.id_ciudad = ci.id_ciudad
AND ci.nombre = 'Fuenlabrada';

--SQL2
SELECT DISTINCT d.*
FROM direccion d
INNER JOIN ciudad ci ON d.id_ciudad = ci.id_ciudad
INNER JOIN cliente c ON ci.id_ciudad = c.id_ciudad
WHERE ci.nombre = 'Fuenlabrada';

```
7. Devuelve el nombre de los clientes y el nombre de sus representantes junto con la ciudad de la oficina a la que pertenece el representante.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c, empleado e, oficina_direccion o, direccion d
WHERE c.codigo_empleado_rep_ventas = e.codigo_empleado
AND e.codigo_oficina = o.codigo_oficina
AND o.id_direccion = d.id_direccion;

--SQL2
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina_direccion o ON e.codigo_oficina = o.codigo_oficina
INNER JOIN direccion d ON o.id_direccion = d.id_direccion;

+----------------+-----------------+--------------------+-----------+
| nombre_cliente | nombre_empleado | apellido_empleado1 | id_ciudad |
+----------------+-----------------+--------------------+-----------+
| Cliente 1      | Juan            | Pérez              |         1 |
| Cliente 2      | Luisa           | Martínez           |         2 |
| Cliente 3      | Carlos          | Gomez              |         3 |
| Cliente 4      | María           | Garcia             |         4 |
| Cliente 5      | Ana             | Lopez              |         5 |
| Cliente 6      | Miguel          | Hernández          |         6 |
+----------------+-----------------+--------------------+-----------+
```
8. Devuelve un listado con el nombre de los empleados junto con el nombre de sus jefes.
```sql
--SQL1
SELECT c.nombre_cliente, e.nombre_empleado, e.apellido_empleado1, d.id_ciudad
FROM cliente c
INNER JOIN empleado e ON c.codigo_empleado_rep_ventas = e.codigo_empleado
INNER JOIN oficina_direccion o ON e.codigo_oficina = o.codigo_oficina
INNER JOIN direccion d ON o.id_direccion = d.id_direccion;

--SQL2
SELECT e1.nombre_empleado AS empleado, e2.nombre_empleado AS jefe
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado;

+----------------+-----------------+--------------------+-----------+
| nombre_cliente | nombre_empleado | apellido_empleado1 | id_ciudad |
+----------------+-----------------+--------------------+-----------+
| Cliente 1      | Juan            | Pérez              |         1 |
| Cliente 2      | Luisa           | Martínez           |         2 |
| Cliente 3      | Carlos          | Gomez              |         3 |
| Cliente 4      | María           | Garcia             |         4 |
| Cliente 5      | Ana             | Lopez              |         5 |
| Cliente 6      | Miguel          | Hernández          |         6 |
+----------------+-----------------+--------------------+-----------+
```
9. Devuelve un listado que muestre el nombre de cada empleados, el nombre de su jefe y el nombre del jefe de sus jefe.
```sql
--SQL1
SELECT e1.nombre_empleado AS empleado, e2.nombre_empleado AS jefe, e3.nombre_empleado AS jefe_de_jefe
FROM empleado e1, empleado e2, empleado e3
WHERE e1.codigo_jefe = e2.codigo_empleado
AND e2.codigo_jefe = e3.codigo_empleado;

--SQL2
SELECT e1.nombre_empleado AS empleado, e2.nombre_empleado AS jefe, e3.nombre_empleado AS jefe_de_jefe
FROM empleado e1
INNER JOIN empleado e2 ON e1.codigo_jefe = e2.codigo_empleado
INNER JOIN empleado e3 ON e2.codigo_jefe = e3.codigo_empleado;

```
10. Devuelve el nombre de los clientes a los que no se les ha entregado a tiempo un pedido.
```sql
--SQL1
SELECT DISTINCT c.nombre_cliente
FROM cliente c, pedido p
WHERE c.codigo_cliente = p.codigo_cliente
AND p.fecha_entrega > p.fecha_esperada;

--SQL2
SELECT DISTINCT c.nombre_cliente
FROM cliente c
INNER JOIN pedido p ON c.codigo_cliente = p.codigo_cliente
WHERE p.fecha_entrega > p.fecha_esperada;

```
11. Devuelve un listado de las diferentes gamas de producto que ha comprado cada cliente.
```sql
--SQL1
SELECT DISTINCT c.nombre_cliente, p.id_gama
FROM cliente c, pedido pe, detalle_pedido dp, producto p
WHERE c.codigo_cliente = pe.codigo_cliente
AND pe.codigo_pedido = dp.codigo_pedido
AND dp.codigo_producto = p.codigo_producto;

--SQL2
SELECT DISTINCT c.nombre_cliente, p.id_gama
FROM cliente c
INNER JOIN pedido pe ON c.codigo_cliente = pe.codigo_cliente
INNER JOIN detalle_pedido dp ON pe.codigo_pedido = dp.codigo_pedido
INNER JOIN producto p ON dp.codigo_producto = p.codigo_producto;

+----------------+--------------+
| nombre_cliente | id_gama      |
+----------------+--------------+
| Cliente 1      | Electrónica  |
| Cliente 2      | Electrónica  |
| Cliente 3      | Hogar        |
| Cliente 4      | Jardinería   |
| Cliente 5      | Deporte      |
| Cliente 6      | Moda         |
+----------------+--------------+
```

## Procedimientos
1. Actualizar producto.
```sql
CREATE PROCEDURE actualizar_producto(
    IN codigo_producto_param VARCHAR(15),
    IN nombre_param VARCHAR(70),
    IN id_gama_param VARCHAR(50),
    IN id_dimensiones_param VARCHAR(25),
    IN id_proveedor_param VARCHAR(50),
    IN descripcion_param TEXT,
    IN cantidad_en_stock_param SMALLINT(6),
    IN precio_venta_param DECIMAL(15, 2),
    IN precio_proveedor_param DECIMAL(15, 2)
)
BEGIN
    UPDATE producto
    SET nombre = nombre_param,
        id_gama = id_gama_param,
        id_dimensiones = id_dimensiones_param,
        id_proveedor = id_proveedor_param,
        descripcion = descripcion_param,
        cantidad_en_stock = cantidad_en_stock_param,
        precio_venta = precio_venta_param,
        precio_proveedor = precio_proveedor_param
    WHERE codigo_producto = codigo_producto_param;
END;
```
2. Crear nueva gama de producto.
```sql
CREATE PROCEDURE crear_gama_producto(
    IN gama_param VARCHAR(50),
    IN descripcion_texto_param TEXT,
    IN descripcion_html_param TEXT,
    IN imagen_param VARCHAR(256)
)
BEGIN
    INSERT INTO gama_producto (gama, descripcion_texto, descripcion_html, imagen)
    VALUES (gama_param, descripcion_texto_param, descripcion_html_param, imagen_param);
END;
```
3. Eliminar cliente.
```sql
CREATE PROCEDURE eliminar_cliente(
    IN codigo_cliente_param INT(11)
)
BEGIN
    DELETE FROM cliente WHERE codigo_cliente = codigo_cliente_param;
    DELETE FROM contacto WHERE id_contacto IN (SELECT id_contacto FROM cliente WHERE codigo_cliente = codigo_cliente_param);
    DELETE FROM direccion WHERE id_direccion IN (SELECT id_direccion FROM cliente WHERE codigo_cliente = codigo_cliente_param);
END;
```
4. Buscar pedidos por cliente.
```sql
CREATE PROCEDURE buscar_pedidos_por_cliente(
    IN codigo_cliente_param INT(11)
)
BEGIN
    SELECT *
    FROM pedido
    WHERE codigo_cliente = codigo_cliente_param;
END;
```
5. Actualizar pago.
```sql
CREATE PROCEDURE actualizar_pago(
    IN id_transaccion_param VARCHAR(50),
    IN codigo_cliente_param INT(11),
    IN forma_pago_param VARCHAR(40),
    IN fecha_pago_param DATE,
    IN total_param DECIMAL(15, 2)
)
BEGIN
    UPDATE pago
    SET codigo_cliente = codigo_cliente_param,
        forma_pago = forma_pago_param,
        fecha_pago = fecha_pago_param,
        total = total_param
    WHERE id_transaccion = id_transaccion_param;
END;
```
6. Crear nuevo país.
```sql
CREATE PROCEDURE crear_pais(
    IN nombre_param VARCHAR(100)
)
BEGIN
    INSERT INTO pais (nombre)
    VALUES (nombre_param);
END;
```
7. Eliminar empleado.
```sql
CREATE PROCEDURE eliminar_empleado(
    IN codigo_empleado_param INT(11)
)
BEGIN
    DELETE FROM empleado WHERE codigo_empleado = codigo_empleado_param;
END;
```
8. Buscar productos en stock.
```sql
CREATE PROCEDURE buscar_productos_en_stock()
BEGIN
    SELECT *
    FROM producto
    WHERE cantidad_en_stock > 0;
END;
```
9. Crear nueva región.
```sql
CREATE PROCEDURE crear_region(
    IN nombre_param VARCHAR(100),
    IN id_pais_param INT(11)
)
BEGIN
    INSERT INTO region (nombre, id_pais)
    VALUES (nombre_param, id_pais_param);
END;
```
10. Eliminar pedido.
```sql
CREATE PROCEDURE eliminar_pedido(
    IN codigo_pedido_param INT(11)
)
BEGIN
    DELETE FROM pedido WHERE codigo_pedido = codigo_pedido_param;
END;
```
## Vistas
1. Vista de Productos con Detalles de Proveedor.
```sql
CREATE VIEW vista_productos_con_proveedor AS
SELECT p.*, pr.nombre_proveedor
FROM producto p
LEFT JOIN proveedor pr ON p.id_proveedor = pr.id_proveedor;
```
2. Vista de Pedidos Pendientes.
```sql
CREATE VIEW vista_pedidos_pendientes AS
SELECT *
FROM pedido
WHERE estado = 'pendiente';
```
3. Vista de Clientes con Información de Contacto.
```sql
CREATE VIEW vista_clientes_con_contacto AS
SELECT c.*, con.telefono, con.fax
FROM cliente c
LEFT JOIN contacto con ON c.id_contacto = con.id_contacto;
```
4. Vista de Detalles de Pedido con Productos.
```sql
CREATE VIEW vista_detalles_pedido_con_productos AS
SELECT dp.*, p.nombre
FROM detalle_pedido dp
LEFT JOIN producto p ON dp.codigo_producto = p.codigo_producto;
```
5. Vista de Empleados con Información de Oficina.
```sql
CREATE VIEW vista_empleados_con_oficina AS
SELECT e.*, of.nombre AS nombre_oficina, of.telefono AS telefono_oficina
FROM empleado e
LEFT JOIN oficina of ON e.codigo_oficina = of.codigo_oficina;
```
6. Vista de Pagos Recientes.
```sql
CREATE VIEW vista_pagos_recientes AS
SELECT *
FROM pago
WHERE fecha_pago >= DATE_SUB(NOW(), INTERVAL 1 MONTH);
```
7. Vista de Dimensiones de Productos.
```sql
CREATE VIEW vista_dimensiones_producto AS
SELECT id_dimensiones, ancho, alto, profundo, diametro
FROM dimensiones;
```
8. Vista de Regiones con Países.
```sql
CREATE VIEW vista_regiones_con_paises AS
SELECT r.*, p.nombre AS nombre_pais
FROM region r
LEFT JOIN pais p ON r.id_pais = p.id_pais;
```
9. Vista de Ciudades con Regiones.
```sql
CREATE VIEW vista_ciudades_con_regiones AS
SELECT c.*, r.nombre AS nombre_region
FROM ciudad c
LEFT JOIN region r ON c.id_region = r.id_region;
```
10. Vista de Gamas de Productos con Descripciones.
```sql
CREATE VIEW vista_gamas_con_descripciones AS
SELECT g.*, d.descripcion_texto
FROM gama_producto g
LEFT JOIN descripcion d ON g.gama = d.gama;
```