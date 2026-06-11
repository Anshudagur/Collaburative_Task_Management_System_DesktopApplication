CREATE PROC spInsertDataIntoTaskPriorityTable
@PriorityName VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRY

        SET @PriorityName = LTRIM(RTRIM(ISNULL(@PriorityName,'')));

        IF LEN(@PriorityName) > 50
        BEGIN
            SELECT 
                0 AS StatusCode, 
                'Priority Name cannot exceed 50 characters.' AS Message;
            RETURN;
        END;

        IF @PriorityName = ''
        BEGIN
            SELECT
                0 AS StatusCode,
                'Priority Name is required.' AS Message;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM tblTaskPriority
            WHERE PriorityName = @PriorityName
        )
        BEGIN
            SELECT
                0 AS StatusCode,
                'Priority Name already exists.' AS Message;
            RETURN;
        END;

        INSERT INTO tblTaskPriority
        (
            PriorityName
        )
        VALUES
        (
            @PriorityName
        );

        SELECT
            1 AS StatusCode,
            'Priority Name inserted successfully.' AS Message;

    END TRY
    BEGIN CATCH

        SELECT
            0 AS StatusCode,
            ERROR_MESSAGE() AS Message,
            ERROR_NUMBER() AS ErrorNumber,
            ERROR_LINE() AS ErrorLine,
            ERROR_PROCEDURE() AS ErrorProcedure;

    END CATCH
END;