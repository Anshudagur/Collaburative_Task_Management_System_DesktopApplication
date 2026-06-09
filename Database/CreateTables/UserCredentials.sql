CREATE TABLE tblUserCredentials(
    UserId INT NOT NULL,
    PasswordHash VARCHAR(255) NOT NULL,
    Salt VARCHAR(255) NOT NULL,
    IsFrozen BIT NOT NULL DEFAULT 0,
    FreezeUntil DATETIME NULL,

    CONSTRAINT PK_tblUserCredentials_UserId
        PRIMARY KEY (UserId),
    CONSTRAINT FK_tblUserCredentials_UserId_tblUsers
        FOREIGN KEY (UserId)
        REFERENCES tblUsers(UserId)
);