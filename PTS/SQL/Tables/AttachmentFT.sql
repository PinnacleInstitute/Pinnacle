EXEC [dbo].pts_CheckTable 'AttachmentFT'
 GO

CREATE TABLE [dbo].[AttachmentFT] (
   [AttachmentID] int NOT NULL ,
   [FT] nvarchar (3100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AttachmentFT] WITH NOCHECK ADD
   CONSTRAINT [DF_Attachment_FT] DEFAULT ('') FOR [FT] 
GO

ALTER TABLE [dbo].[AttachmentFT] WITH NOCHECK ADD
   CONSTRAINT [PK_AttachmentFT] PRIMARY KEY NONCLUSTERED
   ([AttachmentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO
