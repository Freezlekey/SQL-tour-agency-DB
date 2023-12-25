CREATE VIEW TicketSalesStatistics AS
SELECT
    Class_ticket,
    Departure_country,
    Arrival_country,
    COUNT(*) AS TicketsSold,
    SUM(Price_ticket) AS TotalRevenue
FROM
dbo.[Order] O
INNER JOIN dbo.Ticket t ON O.ID_ticket = t.ID_ticket
JOIN dbo.Flight f ON t.ID_flight = f.ID_flight
GROUP BY Class_ticket, Departure_country, Arrival_country;
SELECT * FROM TicketSalesStatistics;