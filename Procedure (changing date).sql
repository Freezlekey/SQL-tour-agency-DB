CREATE PROCEDURE UpdateTourDates
    @OrderID INT,
    @NewStartDate DATE
AS
BEGIN
    SET NOCOUNT ON;
    -- Обновление дат в таблице Flight
    UPDATE dbo.Flight
    SET Departure_date = @NewStartDate
    WHERE ID_flight IN (SELECT t.ID_flight FROM dbo.Ticket t
	INNER JOIN dbo.[Order] o ON t.ID_ticket = o.ID_ticket WHERE o.ID_order = @OrderID);
    -- Обновление дат в таблице Tour
    UPDATE dbo.Tour
    SET Date_start = @NewStartDate,
        Date_end = DATEADD(DAY, 9, @NewStartDate)
    WHERE ID_tour IN (SELECT ID_tour FROM dbo.[Order] WHERE ID_order = @OrderID);
    SELECT * FROM dbo.Tour WHERE ID_tour IN (SELECT ID_tour FROM dbo.[Order] WHERE ID_order = @OrderID);
END;

DECLARE @TourIDToUpdate INT = 1;
DECLARE @NewStartDateToUpdate DATE = '2023-12-';
EXEC UpdateTourDates 
    @OrderID = 1,
    @NewStartDate = '2023-12-26';