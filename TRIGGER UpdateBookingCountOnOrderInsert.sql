CREATE TRIGGER UpdateBookingCountOrder
ON dbo.[Order]
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    -- Обновляем Number_of_bookings для каждого ID_tour
    UPDATE b
    SET Number_of_bookings = ISNULL((
        SELECT COUNT(o.ID_order) 
        FROM dbo.[Order] o
        INNER JOIN dbo.Tour t ON o.ID_tour = t.ID_tour
        WHERE t.ID_booking = b.ID_booking
    ), 0)
    FROM dbo.Booking b
    INNER JOIN dbo.Tour t ON b.ID_booking = t.ID_booking
    INNER JOIN inserted i ON t.ID_tour = i.ID_tour;
END;

DROP TRIGGER UpdateBookingCountOrder