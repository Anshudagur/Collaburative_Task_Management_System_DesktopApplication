CREATE TABLE tblRequestStatus(
    StatusId INT IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblRequestStatus_StatusId
        PRIMARY KEY (StatusId),

    CONSTRAINT UQ_tblRequestStatus_StatusName
        UNIQUE (StatusName)
);