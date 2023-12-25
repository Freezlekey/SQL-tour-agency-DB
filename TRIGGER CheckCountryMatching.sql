CREATE TRIGGER CheckCountryMatching
ON dbo.[Order]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (
        SELECT * FROM inserted i
        INNER JOIN dbo.Tour t ON i.ID_tour = t.ID_tour
        INNER JOIN dbo.Flight f ON i.ID_ticket = f.ID_flight
        WHERE t.Country <> f.Arrival_country)
    BEGIN
		DECLARE @error NVARCHAR(50);
		SET @error = N'Страна прибытия не совпадает со страной проведения тура, поменяйте значение';
		THROW 50001, @error, 0;
		ROLLBACK;
		RETURN
    END
END;

DROP TRIGGER CheckCountryMatching