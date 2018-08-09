EXEC [dbo].pts_CheckTable 'IssueCategory'
 GO

CREATE TABLE [dbo].[IssueCategory] (
   [IssueCategoryID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [IssueCategoryName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [UserType] int NOT NULL ,
   [AssignedTo] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [InputOptions] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[IssueCategory] WITH NOCHECK ADD
   CONSTRAINT [DF_IssueCategory_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_IssueCategory_IssueCategoryName] DEFAULT ('') FOR [IssueCategoryName] ,
   CONSTRAINT [DF_IssueCategory_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_IssueCategory_UserType] DEFAULT (0) FOR [UserType] ,
   CONSTRAINT [DF_IssueCategory_AssignedTo] DEFAULT ('') FOR [AssignedTo] ,
   CONSTRAINT [DF_IssueCategory_InputOptions] DEFAULT ('') FOR [InputOptions] ,
   CONSTRAINT [DF_IssueCategory_Email] DEFAULT ('') FOR [Email]
GO

ALTER TABLE [dbo].[IssueCategory] WITH NOCHECK ADD
   CONSTRAINT [PK_IssueCategory] PRIMARY KEY NONCLUSTERED
   ([IssueCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_IssueCategory_CompanyID]
   ON [dbo].[IssueCategory]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_IssueCategory_IssueCategoryName]
   ON [dbo].[IssueCategory]
   ([IssueCategoryName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO