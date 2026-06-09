CREATE TABLE tblDurationExtensionRequests(
    RequestId INT IDENTITY(1,1),
    TaskId INT NOT NULL,
    RequestedBy INT NOT NULL,
    NewEndingDate DATE NOT NULL,
    Reason VARCHAR(500) NOT NULL,
    StatusId INT NOT NULL,
    RequestedAt DATETIME NOT NULL DEFAULT GETDATE(),

    CONSTRAINT PK_tblDurationExtensionRequests_RequestId
        PRIMARY KEY (RequestId),

    CONSTRAINT FK_tblDurationExtensionRequests_TaskId_tblTasks
        FOREIGN KEY (TaskId)
        REFERENCES tblTasks(TaskId),

    CONSTRAINT FK_tblDurationExtensionRequests_RequestedBy_tblUsers
        FOREIGN KEY (RequestedBy)
        REFERENCES tblUsers(UserId),

    CONSTRAINT FK_tblDurationExtensionRequests_StatusId_tblRequestStatus
        FOREIGN KEY (StatusId)
        REFERENCES tblRequestStatus(StatusId)
);