CREATE TABLE tblAttachments(
    AttachmentId INT IDENTITY(1,1),
    AttachedFile VARBINARY(MAX) NOT NULL,

    CONSTRAINT PK_tblAttachments_AttachmentId
        PRIMARY KEY (AttachmentId)
);