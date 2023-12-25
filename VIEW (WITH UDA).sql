CREATE VIEW View_InformationForClients AS
SELECT
    o.ID_order,
	c.Name_client,
    c.Lastname_client,
    c.Middlename_client,
	c.Email,
    o.Travel_type,
    o.ID_ticket,
    t.Price_ticket,
    t.Type_ticket,
    tr.Date_start AS Date_tour_start,
    t.Class_ticket,
    f.Number_of_seat,
    f.Symbol_of_seat,
    f.Departure_country,
	tr.Country AS Arrival_Tour_Country
FROM
    dbo.[Order] o
INNER JOIN
    dbo.Ticket t ON o.ID_ticket = t.ID_ticket
INNER JOIN
    dbo.Tour tr ON o.ID_tour = tr.ID_tour
INNER JOIN
    dbo.Flight f ON t.ID_flight = f.ID_flight
INNER JOIN
    dbo.Client c ON o.ID_client_document = c.ID_client_document
--DROP VIEW IF EXISTS View_InformationForClients;

SELECT * FROM View_InformationForClients;

-- Для изменения записи
UPDATE View_InformationForClients
SET Travel_type = N'Семейный', Email = N'okay01@gmail.com'
WHERE ID_order = 1
SELECT * FROM View_InformationForClients;

-- Для добавления новой записи
INSERT INTO View_InformationForClients (Travel_type, ID_ticket, Departure_date)
VALUES (N'Отпуск', 2, '2023-12-20');
SELECT * FROM View_InformationForClients;

-- Для удаления записи
DELETE FROM View_InformationForClients
WHERE ID_order = 3;
SELECT * FROM View_InformationForClients;