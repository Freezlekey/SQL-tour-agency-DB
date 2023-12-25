CREATE VIEW TourServices AS
SELECT
    O.ID_order,
    O.ID_tour,
    S.ID_services,
    S.ID_rent_car AS RentalID,
    S.ID_excursion AS ExcursionID,
    R.Adress_car AS RentalAddress,
    R.Vehicle_type AS RentalVehicleType,
    R.Daily_rent_price AS RentalDailyRentPrice,
    E.Price_excursion AS ExcursionPrice,
    E.Length_hours AS ExcursionLengthHours,
    E.Name_excursion AS ExcursionName
FROM
    dbo.[Order] O
	LEFT JOIN dbo.Tour T ON O.ID_tour = T.ID_tour
    LEFT JOIN dbo.Services S ON T.ID_services = S.ID_services
    LEFT JOIN dbo.Vehicle_Rental R ON S.ID_rent_car = R.ID_rent_car
    LEFT JOIN dbo.Excursion E ON S.ID_excursion = E.ID_excursion;
SELECT * FROM TourServices