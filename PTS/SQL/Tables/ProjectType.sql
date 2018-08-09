EXEC [dbo].pts_CheckTable 'ProjectType'
 GO

CREATE TABLE [dbo].[ProjectType] (
   [ProjectTypeID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ProjectTypeName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProjectType] WITH NOCHECK ADD
   CONSTRAINT [DF_ProjectType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_ProjectType_ProjectTypeName] DEFAULT ('') FOR [ProjectTypeName] ,
   CONSTRAINT [DF_ProjectType_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[ProjectType] WITH NOCHECK ADD
   CONSTRAINT [PK_ProjectType] PRIMARY KEY NONCLUSTERED
   ([ProjectTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProjectType_CompanyID]
   ON [dbo].[ProjectType]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO