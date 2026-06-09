CREATE TABLE tblTasks(
    TaskId INT IDENTITY(1,1),
    ProjectId INT NOT NULL,
    TaskName VARCHAR(100) NOT NULL,
    StartingDate DATE NOT NULL,
    EndingDate DATE NOT NULL,
    Comments VARCHAR(500) NULL,
    PriorityId INT NOT NULL,
    StatusId INT NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy INT NOT NULL,

    CONSTRAINT PK_tblTasks_TaskId
        PRIMARY KEY (TaskId),

    CONSTRAINT CK_tblTasks_EndingDate
        CHECK (EndingDate >= StartingDate),

    CONSTRAINT FK_tblTasks_ProjectId_tblProjects
        FOREIGN KEY (ProjectId)
        REFERENCES tblProjects(ProjectId),

    CONSTRAINT FK_tblTasks_PriorityId_tblTaskPriority
        FOREIGN KEY (PriorityId)
        REFERENCES tblTaskPriority(PriorityId),

    CONSTRAINT FK_tblTasks_StatusId_tblTaskStatus
        FOREIGN KEY (StatusId)
        REFERENCES tblTaskStatus(StatusId),

    CONSTRAINT FK_tblTasks_CreatedBy_tblUsers
        FOREIGN KEY (CreatedBy)
        REFERENCES tblUsers(UserId)
);