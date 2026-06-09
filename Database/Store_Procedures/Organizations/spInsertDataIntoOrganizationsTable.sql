CREATE PROC spInsertDataIntoOrganizationsTable
@OrganizationName VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY

        SET @OrganizationName = LTRIM(RTRIM(ISNULL(@OrganizationName,'')));

        IF LEN(@OrganizationName) > 50
        BEGIN
            SELECT 0 AS StatusCode, 
            'Organization Name cannot exceed 20 characters.' AS Message;
            RETURN;
        END;

        IF @OrganizationName = ''
        BEGIN
            SELECT
                0 AS StatusCode,
                'Organization Name is required.' AS Message;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM tblOrganizations
            WHERE OrganizationName = @OrganizationName
        )
        BEGIN
            SELECT
                0 AS StatusCode,
                'Organization Name already exists.' AS Message;
            RETURN;
        END;

        INSERT INTO tblOrganizations
        (
            OrganizationName
        )
        VALUES
        (
            @OrganizationName
        );

        SELECT
            1 AS StatusCode,
            'Organization Name inserted successfully.' AS Message;

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