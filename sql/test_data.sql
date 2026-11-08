
USE EmpresaDB;
GO

-- Registrar existencias iniciales.
INSERT INTO Inventario(Producto, Existencias)
VALUES
    ('Laptop', 20),
    ('Monitor', 30),
    ('Teclado', 50),
    ('Mouse', 40);
GO

-- Registrar varias ventas al mismo tiempo.
INSERT INTO Ventas(Producto, Cantidad)
VALUES
    ('Laptop', 2),
    ('Monitor', 3),
    ('Teclado', 5),
    ('Mouse', 4);
GO

-- Consultar las ventas registradas.
SELECT * FROM Ventas;
GO

-- Consultar la auditoría.
SELECT * FROM AuditoriaVentas;
GO

-- Consultar las existencias restantes.
SELECT * FROM Inventario;
GO

