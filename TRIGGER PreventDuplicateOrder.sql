CREATE TRIGGER PreventDuplicateOrder
ON dbo.[Order]
INSTEAD OF INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT * FROM inserted i INNER JOIN dbo.[Order] o ON i.ID_client_document = o.ID_client_document AND i.ID_tour = o.ID_tour)
    BEGIN
        DECLARE @ErrorMessage NVARCHAR(4000) = N'Клиент уже добавил этот тур в заказ';
        THROW 50007, @ErrorMessage, 0;
    END
    ELSE
    BEGIN
        -- Вставка данных в таблицу Order
        INSERT INTO dbo.[Order] (ID_employee_document, ID_client_document, Date_of_order, Travel_type, ID_tour, ID_ticket)
        SELECT ID_employee_document, ID_client_document, Date_of_order, Travel_type, ID_tour, ID_ticket
        FROM inserted;
    END
END;