CREATE VIEW TourDetailsView
AS
SELECT
    T.ID_tour,
    T.Date_start,
    T.Date_end,
    T.Tour_name,
    T.Country,
    T.City,
    B.Number_of_bookings,
    H.Name_hotel,
    H.Rating,
    H.Adress_hotel,
    S.ID_services,
    S.ID_rent_car,
    S.ID_excursion,
    E.Length_hours,
    E.Name_excursion
FROM dbo.Tour T
JOIN dbo.[Order] O ON T.ID_tour = O.ID_tour
JOIN dbo.Booking B ON T.ID_booking = B.ID_booking
JOIN dbo.Hotel H ON B.ID_hotel = H.ID_hotel
JOIN dbo.[Services] S ON T.ID_services = S.ID_services
LEFT JOIN dbo.Excursion E ON S.ID_excursion = E.ID_excursion;
SELECT * FROM TourDetailsView;
