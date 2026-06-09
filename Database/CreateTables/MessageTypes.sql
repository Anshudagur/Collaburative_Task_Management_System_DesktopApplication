CREATE TABLE tblMessageTypes(
    MessageTypeId INT IDENTITY(1,1),
    MessageTypeName VARCHAR(20) NOT NULL,

    CONSTRAINT PK_tblMessageTypes_MessageTypesId
        PRIMARY KEY (MessageTypeId),

    CONSTRAINT UQ_tblMessageTypes_MessageTypesName
        UNIQUE (MessageTypeName),
);