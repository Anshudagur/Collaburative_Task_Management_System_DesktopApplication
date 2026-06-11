CREATE TABLE tblTaskAttachments(
    TaskId INT NOT NULL,
    AttachmentId INT NOT NULL,

    CONSTRAINT FK_tblTaskAttachments_TaskId_tblTasks
        FOREIGN KEY (TaskId)
        REFERENCES tblTasks(TaskId),

    CONSTRAINT FK_tblTaskAttachments_AttachmentId_tblAttachments
        FOREIGN KEY (AttachmentId)
        REFERENCES tblAttachments(AttachmentId)
);