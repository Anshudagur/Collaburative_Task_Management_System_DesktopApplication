CREATE TABLE tblLoginAttempts(
    AttemptId INT IDENTITY(1,1),
    UserId INT NOT NULL,
    AttemptedAt DATETIME NOT NULL DEFAULT GETDATE(),
    SuccessStatus BIT NOT NULL,

    CONSTRAINT PK_tblLoginAttempts_AttemptId
        PRIMARY KEY (AttemptId),

    CONSTRAINT FK_tblLoginAttempts_UserId_tblUsers
        FOREIGN KEY (UserId)
        REFERENCES tblUsers(UserId)
);