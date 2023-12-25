CREATE TRIGGER Editting_status_VISA
ON dbo.VISA
AFTER INSERT
AS
BEGIN
    DECLARE @InsertedID INT;
    SELECT @InsertedID = ID_visa FROM INSERTED;

    UPDATE V
    SET VISA_status = dbo.Checking_VISA(V.ID_visa)
    FROM dbo.VISA V
    WHERE V.ID_visa = @InsertedID;
END;

DROP TRIGGER Editting_status_VISA
