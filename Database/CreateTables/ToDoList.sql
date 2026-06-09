CREATE TABLE tblToDoList(
    ToDoId INT IDENTITY(1,1),
    ToDoName VARCHAR(100) NOT NULL,
    Comment VARCHAR(500) NULL,
    StartingDate DATE NOT NULL,
    EndingDate   DATE NOT NULL,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    CreatedBy INT NOT NULL,

    CONSTRAINT PK_tblToDoList_ToDoId
        PRIMARY KEY (ToDoId),

    CONSTRAINT CK_tblToDoList_EndingDate
        CHECK (EndingDate >= StartingDate),

    CONSTRAINT FK_tblToDoList_CreatedBy_tblUsers
        FOREIGN KEY (CreatedBy)
        REFERENCES tblUsers(UserId)
);