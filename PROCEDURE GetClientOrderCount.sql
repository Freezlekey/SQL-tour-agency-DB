CREATE PROCEDURE GetClientOrderCount
AS
BEGIN
    CREATE TABLE #ClientOrderCount (ClientName NVARCHAR(50),OrderCount INT);

    DECLARE ClientCursor CURSOR FOR
    SELECT Name_client
    FROM dbo.Client;

    -- Переменные для хранения значений из курсора
    DECLARE @ClientName NVARCHAR(50);

    OPEN ClientCursor;

    FETCH NEXT FROM ClientCursor INTO @ClientName;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        -- Выполняем запрос для подсчета количества заказов для каждого клиента
        INSERT INTO #ClientOrderCount (ClientName, OrderCount)
        SELECT @ClientName, COUNT(*)
        FROM dbo.[Order] o
        INNER JOIN dbo.Client c ON o.ID_client_document = c.ID_client_document
        WHERE c.Name_client = @ClientName;
        FETCH NEXT FROM ClientCursor INTO @ClientName;
    END
    CLOSE ClientCursor;
    DEALLOCATE ClientCursor;
    SELECT * FROM #ClientOrderCount;
    DROP TABLE #ClientOrderCount;
END;

EXEC GetClientOrderCount;