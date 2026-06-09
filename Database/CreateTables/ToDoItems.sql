CREATE TABLE tblToDoItems(
    ItemId INT IDENTITY(1,1),
    ToDoId INT NOT NULL,
    ItemName VARCHAR(100) NOT NULL,
    Comment VARCHAR(500) NULL,

    CONSTRAINT PK_tblToDoItems_ItemId
        PRIMARY KEY (ItemId),

    CONSTRAINT FK_tblToDoItems_ToDoId_tblToDoList
        FOREIGN KEY (ToDoId)
        REFERENCES tblToDoList(ToDoId)
);