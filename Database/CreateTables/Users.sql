CREATE TABLE tblUsers(
    UserId INT IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    OrganizationId INT NULL,
    ProfilePhoto VARBINARY(MAX),
    RoleId INT NOT NULL,

    CONSTRAINT PK_tblUsers_UserId
		PRIMARY KEY (UserId),
    CONSTRAINT UQ_tblUsers_Email 
        UNIQUE (Email),
    CONSTRAINT FK_tblUsers_OrganizationId_tblOrganizations 
        FOREIGN KEY (OrganizationId) 
        REFERENCES tblOrganizations(OrganizationId),
    CONSTRAINT FK_tblUsers_RoleId_tblRoles 
        FOREIGN KEY (RoleId) 
        REFERENCES tblRoles(RoleId)
);