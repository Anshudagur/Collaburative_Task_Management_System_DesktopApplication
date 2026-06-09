CREATE TABLE tblTaskStatus(
    StatusId INT IDENTITY(1,1),
    StatusName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblTaskStatus_StatusId
        PRIMARY KEY (StatusId),

    CONSTRAINT UQ_tblTaskStatus_StatusName
        UNIQUE (StatusName)
);