CREATE TABLE tblProjects(
    ProjectId INT IDENTITY(1,1),
    ProjectName VARCHAR(100) NOT NULL,
    StartingDate DATE NOT NULL,
    EndingDate DATE NOT NULL,
    Comment VARCHAR(500) NULL,
    StatusId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy INT NOT NULL,

    CONSTRAINT PK_tblProjects_ProjectId
        PRIMARY KEY (ProjectId),

    CONSTRAINT CK_tblProjects_EndingDate
        CHECK (EndingDate >= StartingDate),

    CONSTRAINT FK_tblProjects_StatusId_tblProjectStatus
        FOREIGN KEY (StatusId)
        REFERENCES tblProjectStatus(StatusId),

    CONSTRAINT FK_tblProjects_CreatedBy_tblUsers
        FOREIGN KEY (CreatedBy)
        REFERENCES tblUsers(UserId)
);