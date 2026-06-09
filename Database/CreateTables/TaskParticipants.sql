CREATE TABLE tblTaskParticipants(
    ParticipantId INT IDENTITY(1,1),
    TaskId INT NOT NULL,
    UserId INT NOT NULL,
    Responsibility VARCHAR(100) NOT NULL,

    CONSTRAINT PK_tblTaskParticipants_ParticipantId
        PRIMARY KEY (ParticipantId),

    CONSTRAINT UQ_tblTaskParticipants_TaskId_UserId
        UNIQUE (TaskId, UserId),

    CONSTRAINT FK_tblTaskParticipants_TaskId_tblTasks
        FOREIGN KEY (TaskId)
        REFERENCES tblTasks(TaskId),

    CONSTRAINT FK_tblTaskParticipants_UserId_tblUsers
        FOREIGN KEY (UserId)
        REFERENCES tblUsers(UserId)
);