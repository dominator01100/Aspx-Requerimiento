-- CREACIÓN DE PROCEDIMIENTOS ALMACENADOS --

--------------------------------------------------------------
-- PROVEEDOR --
--------------------------------------------------------------
-- Crear Proveedor
CREATE PROCEDURE SPcrearProveedor (@nombreProveedor VARCHAR(100)) AS BEGIN
INSERT INTO Proveedor (nombreProveedor)
VALUES (@nombreProveedor)
END

-- Listar Proveedores
CREATE PROCEDURE SPlistarProveedor AS BEGIN
SELECT nit,
    CONCAT(nit, ' - ', nombreProveedor) AS texto
FROM Proveedor;
END

--------------------------------------------------------------
-- PRODUCTO --
--------------------------------------------------------------
-- Crear Producto
CREATE PROCEDURE SPcrearProducto (@nombreProducto varchar(100)) AS BEGIN
INSERT INTO Producto (nombreProducto)
VALUES (@nombreProducto)
END

-- Listar Productos
CREATE PROCEDURE SPlistarProductos AS BEGIN
SELECT codigoProducto,
    CONCAT(codigoProducto, ' - ', nombreProducto) AS texto
FROM Producto;
END

--------------------------------------------------------------
-- ORDEN --
--------------------------------------------------------------
-- Generar Número Aleatorio
CREATE PROCEDURE SPRandomGenerator (@salida INT OUTPUT) AS BEGIN
DECLARE @random_num INT;
SET @random_num = FLOOR(Rand() * 999999) WHILE (
        (
            SELECT COUNT(*)
            FROM Orden
            WHERE numero = @random_num
        ) > 0
    ) BEGIN
SET @random_num = FLOOR(Rand() * 99999);
END
SET @salida = @random_num;
SELECT @salida;
END

-- Crear Orden
CREATE PROCEDURE SPcrearOrden (
    @numero INT,
    @fechaOrden DATE,
    @proveedor INT,
    @fechaEntrega DATE
) AS BEGIN
INSERT INTO Orden (numero, fechaOrden, proveedor, fechaEntrega)
VALUES (@numero, @fechaOrden, @proveedor, @fechaEntrega)
END

--Crear Productos en Orden
CREATE PROCEDURE SPproductosEnOrden(
    @orden INT,
    @producto INT,
    @cantidadPedida INT,
    @precio DECIMAL
) AS BEGIN
INSERT INTO ProductoXOrden (orden, producto, cantidadPedida, precio)
VALUES (@orden, @producto, @cantidadPedida, @precio)
END

-- Listar Ordenes Pendientes
CREATE PROCEDURE SPordenesPendientes (@fecha DATE) AS BEGIN
SELECT O.numero,
    P.nit as Nit,
    P.nombreProveedor AS Proveedor,
    O.fechaOrden AS FechaOrden,
    O.fechaEntrega AS FechaEstimada,
    PrecioTotal
FROM Orden O
    INNER JOIN Proveedor P ON O.proveedor = P.nit
    INNER JOIN (
        SELECT orden,
            SUM(precio) AS PrecioTotal
        FROM ProductoXOrden
        GROUP BY orden
    ) PO ON PO.orden = O.numero
WHERE O.fechaEntrega = @fecha
    AND O.estado = 1;
END

-- Cancelar Orden
CREATE PROCEDURE SPcancelarOrden(@numero INT) AS BEGIN
UPDATE Orden
SET estado = 2
WHERE numero = @numero;
END

-- Consulta simple de orden por número
CREATE PROCEDURE SPordenPorID(@orden INT) AS BEGIN
SELECT TOP 1 numero,
    fechaOrden,
    CONCAT(proveedor, ' - ', nombreProveedor) AS Proveedor,
    fechaEntrega
FROM Orden O
    INNER JOIN Proveedor P ON O.proveedor = P.nit
WHERE numero = @orden;
END

-- Consulta simple de detalle por número de orden
CREATE PROCEDURE SPdetallePorID(@orden INT) AS BEGIN
SELECT codigoProducto,
    nombreProducto,
    cantidadPedida,
    cantidadRecibida,
    precio
FROM ProductoXOrden PO
    INNER JOIN Producto P ON PO.producto = P.codigoProducto
WHERE orden = @orden;
END

-- Actualizar estado de Orden
CREATE PROCEDURE SPactualizarOrden(@orden INT) AS BEGIN
UPDATE Orden
SET estado = 3
WHERE numero = @orden;
END

-- Actualizar Producto de Orden
CREATE PROCEDURE SPactualizarPO (
    @orden INT,
    @producto INT,
    @cantidadRecibida INT
) AS BEGIN
UPDATE ProductoXOrden
SET cantidadRecibida = @cantidadRecibida
WHERE producto = @producto
    AND orden = @orden;
END

--------------------------------------------------------------
-- INFORMES --
--------------------------------------------------------------
-- Consulta Orden
SELECT orden,
    fechaOrden,
    nit,
    nombreProveedor,
    fechaEntrega,
    PrecioTotal,
    estado
FROM Orden O
    INNER JOIN (
        SELECT orden,
            SUM(precio) AS PrecioTotal
        FROM ProductoXOrden
        GROUP BY orden
    ) PO ON PO.orden = O.numero
    INNER JOIN Proveedor P ON P.nit = O.proveedor;

-- Consulta Producto
SELECT producto,
    SUM(cantidadPedida) AS CantidadP,
    SUM(cantidadRecibida) AS CantidadR,
    (SUM(precio) / SUM(cantidadPedida)) AS PrecioP,
    SUM(precio) AS PrecioT
FROM ProductoXOrden
GROUP BY producto;

-- Consulta Ordenes Recibidas del Producto
SELECT numero,
    fechaEntrega,
    nit,
    nombreProveedor
FROM (
        SELECT *
        FROM Orden
        WHERE estado = 3
    ) O
    INNER JOIN (
        SELECT *
        FROM ProductoXOrden
        WHERE producto = 1
    ) PO ON O.numero = PO.orden
    INNER JOIN Proveedor P ON P.nit = O.proveedor;