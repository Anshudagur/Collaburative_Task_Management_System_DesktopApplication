CREATE PROC spInsertDataIntoTaskStatus
@StatusName VARCHAR(50)
AS
BEGIN
    BEGIN TRY
        SET NOCOUNT ON;

        SET @StatusName = LTRIM(RTRIM(ISNULL(@StatusName,'')));

        IF LEN(@StatusName) > 50
        BEGIN
            SELECT 
                0 AS StatusCode, 
                'Status Name cannot exceed 50 characters.' AS Message;
            RETURN;
        END;

        IF @StatusName = ''
        BEGIN
            SELECT
                0 AS StatusCode,
                'Status Name is required.' AS Message;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM tblTaskStatus
            WHERE StatusName = @StatusName
        )
        BEGIN
            SELECT
                0 AS StatusCode,
                'Status Name already exists.' AS Message;
            RETURN;
        END;

        INSERT INTO tblTaskStatus
        (
            StatusName
        )
        VALUES
        (
            @StatusName
        );

        SELECT
            1 AS StatusCode,
            'Status Name inserted successfully.' AS Message;

    END TRY
    BEGIN CATCH

        SELECT
            0 AS StatusCode,
            ERROR_MESSAGE() AS Message,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_LINE() AS ErrorLine,
            ERROR_PROCEDURE() AS ErrorProcedure;

    END CATCH
END