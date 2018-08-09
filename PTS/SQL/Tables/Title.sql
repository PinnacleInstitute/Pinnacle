EXEC [dbo].pts_CheckTable 'Title'
 GO

CREATE TABLE [dbo].[Title] (
   [TitleID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [TitleName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TitleNo] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Title] WITH NOCHECK ADD
   CONSTRAINT [DF_Title_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Title_TitleName] DEFAULT ('') FOR [TitleName] ,
   CONSTRAINT [DF_Title_TitleNo] DEFAULT (0) FOR [TitleNo]
GO

ALTER TABLE [dbo].[Title] WITH NOCHECK ADD
   CONSTRAINT [PK_Title] PRIMARY KEY NONCLUSTERED
   ([TitleID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Title_CompanyID]
   ON [dbo].[Title]
   ([CompanyID], [TitleNo])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO