CREATE TRIGGER PreventDuplicateTicket
ON dbo.[Order]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    IF EXISTS (SELECT ID_ticket FROM inserted i
        WHERE EXISTS (
            SELECT * FROM dbo.[Order] o
            WHERE o.ID_ticket = i.ID_ticket
            AND o.ID_order <> i.ID_order -- Исключаем текущий заказ из проверки
        )
    )
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(4000) = N'Ошибка: Билет с указанным ID уже использован в другом заказе.';
        THROW 50000, @ErrorMessage, 1;
        ROLLBACK;
        RETURN;
    END
END;
