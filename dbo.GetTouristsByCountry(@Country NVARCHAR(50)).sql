CREATE FUNCTION dbo.GetTouristsByCountry(@Country NVARCHAR(50))
RETURNS TABLE
AS
RETURN
(
    SELECT c.Name_client, c.Lastname_client, c.Middlename_client
    FROM dbo.Client c
    INNER JOIN dbo.[Order] o ON c.ID_client_document = o.ID_client_document
    INNER JOIN dbo.Tour t ON o.ID_tour = t.ID_tour
    WHERE t.Country = @Country
);
DECLARE @Country NVARCHAR(50) = N'США';
SELECT * FROM dbo.GetTouristsByCountry(N'США');
