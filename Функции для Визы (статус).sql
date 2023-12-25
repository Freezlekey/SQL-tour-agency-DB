CREATE FUNCTION dbo.Checking_VISA(@ID_visa INT)
RETURNS NVARCHAR(50)
BEGIN
	DECLARE @Status NVARCHAR(50);
    DECLARE @Today DATE = GETDATE();
	IF @Today <= (SELECT Date_of_expiration FROM dbo.VISA WHERE ID_visa = @ID_visa)
	SELECT @Status = N'Дейсвительна'
	ELSE SELECT @Status = N'Просрочена'
	RETURN @Status
END;
SELECT dbo.Checking_VISA(2) AS VisaStatus
SELECT dbo.Checking_VISA(4) AS VisaStatus

DROP FUNCTION IF EXISTS Checking_VISA;