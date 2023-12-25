CREATE VIEW View_OrderDetails AS
SELECT
    o.ID_order,
    t.Price_ticket AS Ticket_Price,
    f.Arrival_country,
    tr.Date_start,
    tr.Date_end,
    b.Price_booking_daily AS Accommodation_Price_Per_Day,
    rent.Daily_rent_price AS Rental_Price_Per_Day,
    ex.Price_excursion AS Excursion_Price,
    o.Price AS Total_Price
FROM
    dbo.[Order] o
INNER JOIN
    dbo.Ticket t ON o.ID_ticket = t.ID_ticket
INNER JOIN
    dbo.Tour tr ON o.ID_tour = tr.ID_tour
INNER JOIN
    dbo.Flight f ON t.ID_flight = f.ID_flight
INNER JOIN
    dbo.Booking b ON tr.ID_booking = b.ID_booking
INNER JOIN
    dbo.[Services] s ON tr.ID_services = s.ID_services
LEFT JOIN
    dbo.Excursion ex ON s.ID_excursion = ex.ID_excursion
LEFT JOIN
    dbo.Vehicle_Rental rent ON s.ID_rent_car = rent.ID_rent_car;

SELECT * FROM View_OrderDetails;

DROP VIEW IF EXISTS View_OrderDetails

