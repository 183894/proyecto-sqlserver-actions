
USE EmpresaDB;
GO

CREATE TRIGGER trg_AuditarVenta
ON Ventas
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @Ventas dbo.VentasInsertadas;

    -- Obtener todas las filas insertadas.
    INSERT INTO @Ventas(VentaID, Producto, Cantidad)
    SELECT VentaID, Producto, Cantidad
    FROM inserted;

    -- Ejecutar el procedimiento almacenado.
    EXEC sp_RegistrarAuditoria @Ventas = @Ventas;
END;
GO

