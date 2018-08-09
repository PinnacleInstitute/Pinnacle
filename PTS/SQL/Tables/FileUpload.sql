EXEC [dbo].pts_CheckTable 'FileUpload'
 GO

CREATE TABLE [dbo].[FileUpload] (
   [FileUploadID] int IDENTITY (1,1) NOT NULL ,
   [FileName] varchar (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FileSize] int NOT NULL ,
   [Status] int NOT NULL ,
   [UploadIP] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [UploadDate] datetime NOT NULL ,
   [UserID] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FileUpload] WITH NOCHECK ADD
   CONSTRAINT [DF_FileUpload_FileName] DEFAULT ('') FOR [FileName] ,
   CONSTRAINT [DF_FileUpload_FileSize] DEFAULT (0) FOR [FileSize],
   CONSTRAINT [DF_FileUpload_Status] DEFAULT (0) FOR [Status],
   CONSTRAINT [DF_FileUpload_UploadIP] DEFAULT ('') FOR [UploadIP] ,
   CONSTRAINT [DF_FileUpload_UploadDate] DEFAULT (0) FOR [UploadDate] ,
   CONSTRAINT [DF_FileUpload_UserID] DEFAULT (0) FOR [UserID]
GO

ALTER TABLE [dbo].[FileUpload] WITH NOCHECK ADD
   CONSTRAINT [PK_FileUpload] PRIMARY KEY NONCLUSTERED
   ([FileUploadID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

