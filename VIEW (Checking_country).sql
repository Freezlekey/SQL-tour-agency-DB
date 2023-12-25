CREATE VIEW Checking_Country
AS
SELECT f.Arrival_country, tr.Country, f.Departure_date FROM Flight f
INNER JOIN Ticket t ON t.ID_flight = f.ID_flight
INNER JOIN [Order] o ON o.ID_ticket = t.ID_ticket
INNER JOIN Tour tr ON tr.ID_tour = o.ID_tour
