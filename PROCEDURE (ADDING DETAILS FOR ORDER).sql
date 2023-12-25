CREATE PROCEDURE InsertOrderWithDetails
    @TourOperatorID INT,
    @ClientID INT,
    @TourID INT,
    @TicketID INT,
    @TravelType NCHAR(10),
	@OldIDOrder INT OUTPUT
AS
BEGIN
    BEGIN TRY
        BEGIN TRANSACTION;
        -- Проверка существования Tour Operator
        IF NOT EXISTS (SELECT * FROM dbo.Tour_operator WHERE ID_employee_document = @TourOperatorID)
        BEGIN
            DECLARE @ErrorMessage NVARCHAR(4000) = N'Tour Operator с указанным ID не найден';
            THROW 50002, @ErrorMessage, 0;
        END
        -- Проверка существования Client
        IF NOT EXISTS (SELECT * FROM dbo.Client WHERE ID_client_document = @ClientID)
        BEGIN
            SET @ErrorMessage = N'Client с указанным ID не найден';
            THROW 50003, @ErrorMessage, 0;
        END
        -- Проверка существования Tour
        IF NOT EXISTS (SELECT * FROM dbo.Tour WHERE ID_tour = @TourID)
        BEGIN
            SET @ErrorMessage = N'Tour с указанным ID не найден';
            THROW 50004, @ErrorMessage, 0;
        END
        -- Проверка существования Ticket
        IF NOT EXISTS (SELECT * FROM dbo.Ticket WHERE ID_ticket = @TicketID)
        BEGIN
            SET @ErrorMessage = N'Ticket с указанным ID не найден';
            THROW 50005, @ErrorMessage, 0;
        END

        DECLARE @OrderDate DATE = GETDATE();
        SELECT @OldIDOrder = IDENT_CURRENT('dbo.[Order]');

        INSERT INTO dbo.[Order] (ID_employee_document, ID_client_document, Date_of_order, Travel_type, ID_tour, ID_ticket)
        VALUES (@TourOperatorID, @ClientID, @OrderDate, @TravelType, @TourID, @TicketID);

        COMMIT;
		PRINT N'Данные добавлены успешно!';
    END TRY
    BEGIN CATCH
        ROLLBACK;
		IF @OldIDOrder IS NOT NULL
			DBCC CHECKIDENT('dbo.[Order]', RESEED, @OldIDOrder);
		SET @ErrorMessage = ERROR_MESSAGE();
        THROW 50001, @ErrorMessage, 0;
    END CATCH;
END;
DECLARE @OldIDOrder INT;
EXEC InsertOrderWithDetails
    @TourOperatorID = 2,  
    @ClientID = 3,         
    @TourID = 3,
    @TicketID = 10,
    @TravelType = N'Бизнес',
    @OldIDOrder = @OldIDOrder OUTPUT;