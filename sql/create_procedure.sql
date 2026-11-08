
USE EmpresaDB;
GO

CREATE PROCEDURE sp_RegistrarAuditoria
    @Ventas dbo.VentasInsertadas READONLY
AS
BEGIN
    SET NOCOUNT ON;

    -- Verificar que existan suficientes productos
    -- para realizar todas las ventas.
    IF EXISTS (
        SELECT 1
        FROM (
            SELECT Producto, SUM(Cantidad) AS CantidadVendida
            FROM @Ventas
            GROUP BY Producto
        ) AS V
        LEFT JOIN Inventario AS I
            ON I.Producto = V.Producto
        WHERE I.Producto IS NULL
           OR I.Existencias < V.CantidadVendida
    )
    BEGIN
        THROW 50001,
              'No hay suficientes existencias para realizar la venta.',
              1;
    END;

    -- Actualizar el inventario por conjunto.
    UPDATE I
    SET I.Existencias = I.Existencias - V.CantidadVendida
    FROM Inventario AS I
    INNER JOIN (
        SELECT Producto, SUM(Cantidad) AS CantidadVendida
        FROM @Ventas
        GROUP BY Producto
    ) AS V
        ON I.Producto = V.Producto;

    -- Registrar la auditoría de cada venta.
    INSERT INTO AuditoriaVentas(VentaID, Mensaje)
    SELECT VentaID, 'Venta registrada automáticamente'
    FROM @Ventas;
END;
GO
