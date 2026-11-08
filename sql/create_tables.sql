
USE EmpresaDB;
GO

CREATE TABLE Ventas(
    VentaID INT IDENTITY(1,1) PRIMARY KEY,
    Producto VARCHAR(100) NOT NULL,
    Cantidad INT NOT NULL CHECK (Cantidad > 0),
    Fecha DATETIME DEFAULT GETDATE()
);
GO

CREATE TABLE AuditoriaVentas(
    AuditoriaID INT IDENTITY(1,1) PRIMARY KEY,
    VentaID INT NOT NULL,
    FechaRegistro DATETIME DEFAULT GETDATE(),
    Mensaje VARCHAR(255) NOT NULL
);
GO

CREATE TABLE Inventario(
    Producto VARCHAR(100) PRIMARY KEY,
    Existencias INT NOT NULL CHECK (Existencias >= 0)
);
GO

CREATE TYPE dbo.VentasInsertadas AS TABLE(
    VentaID INT,
    Producto VARCHAR(100),
    Cantidad INT
);
GO

