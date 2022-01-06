-- CREACIÓN DE TABLAS
CREATE TABLE Proveedor (
    nit INT IDENTITY (1000, 1) PRIMARY KEY,
    nombreProveedor VARCHAR(100) NOT NULL,
);

CREATE TABLE Producto (
    codigoProducto INT IDENTITY (1, 1) PRIMARY KEY,
    nombreProducto VARCHAR(100) NOT NULL
);

CREATE TABLE Estado (
    id INT PRIMARY KEY,
    valor VARCHAR(50) NOT NULL
);

INSERT INTO Estado
VALUES (1, 'Pendiente');
INSERT INTO Estado
VALUES (2, 'Cancelada');
INSERT INTO Estado
VALUES (3, 'Recibida');

CREATE TABLE Orden (
    numero INT PRIMARY KEY,
    fechaOrden DATE NOT NULL DEFAULT GETDATE(),
    proveedor INT NOT NULL REFERENCES Proveedor (nit),
    fechaEntrega DATE,
    estado INT NOT NULL REFERENCES Estado(id) DEFAULT 1
);

CREATE TABLE ProductoXOrden (
    orden INT REFERENCES Orden (numero),
    producto INT REFERENCES Producto (codigoProducto),
    cantidadPedida INT NOT NULL,
    cantidadRecibida INT NOT NULL DEFAULT 0,
    precio DECIMAL NOT NULL,
    PRIMARY KEY (orden, producto)
);