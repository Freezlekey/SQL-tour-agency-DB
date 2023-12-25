--DROP Trigger UpdateOrderPrice
CREATE TRIGGER UpdateOrderPrice
ON dbo.[Order]
AFTER INSERT
AS
BEGIN
    UPDATE o
    SET o.Price = COALESCE(tk.Price_ticket, 0) + 
                   COALESCE(e.Price_excursion, 0) + 
                   COALESCE(b.Price_booking_daily, 0) * DATEDIFF(DAY, t.Date_start, t.Date_end) + 
                   COALESCE(v.Daily_rent_price, 0) * DATEDIFF(DAY, t.Date_start, t.Date_end)
    FROM dbo.[Order] o
    INNER JOIN INSERTED i ON o.ID_order = i.ID_order
    LEFT JOIN dbo.Tour t ON o.ID_tour = t.ID_tour
    LEFT JOIN dbo.Ticket tk ON o.ID_ticket = tk.ID_ticket
    LEFT JOIN dbo.Excursion e ON t.ID_services = e.ID_excursion
    LEFT JOIN dbo.Booking b ON t.ID_booking = b.ID_booking
    LEFT JOIN dbo.Vehicle_Rental v ON t.ID_services = v.ID_rent_car;
END;

DROP TRIGGER UpdateOrderPrice