CREATE TABLE tblRoles(
	RoleId INT IDENTITY(1,1),
	RoleName VARCHAR(50) NOT NULL,

	CONSTRAINT PK_tblRoles_RoleId
		PRIMARY KEY (RoleId),
	CONSTRAINT UQ_tblRoles_RoleName 
		UNIQUE (RoleName)
);