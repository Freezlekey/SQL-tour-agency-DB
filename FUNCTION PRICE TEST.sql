CREATE FUNCTION [dbo].[CountingTotalPriceToOrder](@Last_ID_order INT)
RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE @TotalPrice DECIMAL(10, 2);
    SELECT
        @TotalPrice = COALESCE(SUM(t.Price_ticket), 0)
                    + COALESCE(SUM(ex.Price_excursion), 0)
                    + COALESCE(SUM(b.Price_booking_daily * DATEDIFF(DAY, tr.Date_start, tr.Date_end)), 0)
                    + COALESCE(SUM(rent.Daily_rent_price * DATEDIFF(DAY, tr.Date_start, tr.Date_end)), 0)
    FROM
        dbo.[Order] o
    INNER JOIN
        dbo.Ticket t ON o.ID_ticket = t.ID_ticket
    INNER JOIN
        dbo.Tour tr ON o.ID_tour = tr.ID_tour
    INNER JOIN
        dbo.Booking b ON tr.ID_booking = b.ID_booking
    INNER JOIN
        dbo.Services s ON tr.ID_services = s.ID_services
    LEFT JOIN
        dbo.Excursion ex ON s.ID_excursion = ex.ID_excursion
    LEFT JOIN
        dbo.Vehicle_Rental rent ON s.ID_rent_car = rent.ID_rent_car
    WHERE
        o.ID_order = @Last_ID_order;
    RETURN @TotalPrice;
END;
--DROP FUNCTION [dbo].[CountingTotalPriceToOrder];
SELECT [dbo].[CountingTotalPriceToOrder](1) as Total_Price;
