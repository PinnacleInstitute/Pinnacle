EXEC [dbo].pts_CheckTableRebuild 'Attachment'
 GO

ALTER TABLE [dbo].[Attachment] WITH NOCHECK ADD
   CONSTRAINT [DF_Attachment_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Attachment_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Attachment_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Attachment_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Attachment_AttachName] DEFAULT ('') FOR [AttachName] ,
   CONSTRAINT [DF_Attachment_FileName] DEFAULT ('') FOR [FileName] ,
   CONSTRAINT [DF_Attachment_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Attachment_ParentType] DEFAULT (0) FOR [ParentType] ,
   CONSTRAINT [DF_Attachment_AttachSize] DEFAULT (0) FOR [AttachSize] ,
   CONSTRAINT [DF_Attachment_AttachDate] DEFAULT (0) FOR [AttachDate] ,
   CONSTRAINT [DF_Attachment_ExpireDate] DEFAULT (0) FOR [ExpireDate] ,
   CONSTRAINT [DF_Attachment_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Attachment_IsLink] DEFAULT (0) FOR [IsLink] ,
   CONSTRAINT [DF_Attachment_Secure] DEFAULT (0) FOR [Secure] ,
   CONSTRAINT [DF_Attachment_Score] DEFAULT (0) FOR [Score]
GO

ALTER TABLE [dbo].[Attachment] WITH NOCHECK ADD
   CONSTRAINT [PK_Attachment] PRIMARY KEY NONCLUSTERED
   ([AttachmentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Attachment_ParentID]
   ON [dbo].[Attachment]
   ([ParentID], [ParentType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Attachment_CompanyID]
   ON [dbo].[Attachment]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO