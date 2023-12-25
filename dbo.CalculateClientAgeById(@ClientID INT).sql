CREATE FUNCTION dbo.CalculateClientAgeById(@ClientID INT)
RETURNS INT
AS
BEGIN
    DECLARE @CurrentDate DATE = GETDATE();
    DECLARE @Age INT;

    SELECT @Age = DATEDIFF(YEAR, Date_Of_Birth_client, @CurrentDate) -
    CASE
        WHEN DATEADD(YEAR, DATEDIFF(YEAR, Date_Of_Birth_client, @CurrentDate), Date_Of_Birth_client) > @CurrentDate
        THEN 1
        ELSE 0
    END
    FROM dbo.Client
    WHERE ID_client_document = @ClientID;

    RETURN @Age;
END;

DECLARE @ClientID INT = 2;
SELECT dbo.CalculateClientAgeById(2) AS ClientAge;
