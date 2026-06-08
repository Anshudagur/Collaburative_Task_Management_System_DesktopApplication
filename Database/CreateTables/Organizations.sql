CREATE TABLE tblOrganizations(
	OrganizationId INT IDENTITY(1,1),
	OrganizationName VARCHAR(50) NOT NULL,

	CONSTRAINT PK_tblOrganizations_OrganizationId
		PRIMARY KEY (OrganizationId),
	CONSTRAINT UQ_tblOrganizations_OrganizationName
		UNIQUE (OrganizationName)
);