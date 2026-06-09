CREATE PROC spInsertDataIntoRolesTable
@RoleName VARCHAR(50)
AS
BEGIN
	SET NOCOUNT ON;

    BEGIN TRY

        SET @RoleName = LTRIM(RTRIM(ISNULL(@RoleName,'')));

        IF LEN(@RoleName) > 50
        BEGIN
            SELECT 0 AS StatusCode, 'Role Name cannot exceed 50 characters.' AS Message;
            RETURN;
        END;

        IF @RoleName = ''
        BEGIN
            SELECT
                0 AS StatusCode,
                'Role Name is required.' AS Message;
            RETURN;
        END;

        IF EXISTS
        (
            SELECT 1
            FROM tblRoles
            WHERE RoleName = @RoleName
        )
        BEGIN
            SELECT
                0 AS StatusCode,
                'Role Name already exists.' AS Message;
            RETURN;
        END;

        INSERT INTO tblRoles
        (
            RoleName
        )
        VALUES
        (
            @RoleName
        );

        SELECT
            1 AS StatusCode,
            'Role inserted successfully.' AS Message;

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