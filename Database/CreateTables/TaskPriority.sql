CREATE TABLE tblTaskPriority(
    PriorityId INT IDENTITY(1,1),
    PriorityName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_tblTaskPriority_PriorityId
        PRIMARY KEY (PriorityId),

    CONSTRAINT UQ_tblTaskPriority_PriorityName
        UNIQUE (PriorityName)
);