CREATE TABLE tblNotifications(
    NotificationId INT IDENTITY(1,1),
    TaskId INT NOT NULL,
    MessageTemplate VARCHAR(500) NOT NULL,
    MessageTypeId INT NOT NULL,
    ReminderDaysBefore INT NOT NULL,

    CONSTRAINT PK_tblNotifications_NotificationId
        PRIMARY KEY (NotificationId),

    CONSTRAINT CK_tblNotifications_ReminderDaysBefore
        CHECK (ReminderDaysBefore > 0),

    CONSTRAINT FK_tblNotifications_TaskId_tblTasks
        FOREIGN KEY (TaskId)
        REFERENCES tblTasks(TaskId),

    CONSTRAINT FK_tblNotifications_MessageTypeId_tblMessageTypes
        FOREIGN KEY (MessageTypeId)
        REFERENCES tblMessageTypes(MessageTypeId)
);