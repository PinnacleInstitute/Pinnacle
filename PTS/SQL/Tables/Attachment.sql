EXEC [dbo].pts_CheckTable 'Attachment'
 GO

CREATE TABLE [dbo].[Attachment] (
   [AttachmentID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [RefID] int NOT NULL ,
   [AttachName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FileName] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (3000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ParentType] int NOT NULL ,
   [AttachSize] int NOT NULL ,
   [AttachDate] datetime NOT NULL ,
   [ExpireDate] datetime NOT NULL ,
   [Status] int NOT NULL ,
   [IsLink] bit NOT NULL ,
   [Secure] int NOT NULL ,
   [Score] int NOT NULL 
   ) ON [PRIMARY]
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