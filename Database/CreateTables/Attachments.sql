CREATE TABLE tblAttachments(
    AttachmentId INT          IDENTITY(1,1),
    AttachedFile VARCHAR(255) NOT NULL,

    CONSTRAINT PK_tblAttachments_AttachmentId
        PRIMARY KEY (AttachmentId)
);