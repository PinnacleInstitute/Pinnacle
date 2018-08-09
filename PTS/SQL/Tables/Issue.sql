EXEC [dbo].pts_CheckTable 'Issue'
 GO

CREATE TABLE [dbo].[Issue] (
   [IssueID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [IssueCategoryID] int NOT NULL ,
   [SubmitID] int NOT NULL ,
   [IssueDate] datetime NOT NULL ,
   [IssueName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [SubmittedBy] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [SubmitType] int NOT NULL ,
   [Priority] int NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [AssignedTo] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Notes] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [DueDate] datetime NOT NULL ,
   [DoneDate] datetime NOT NULL ,
   [Variance] int NOT NULL ,
   [InputValues] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Rating] int NOT NULL ,
   [Outsource] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Issue] WITH NOCHECK ADD
   CONSTRAINT [DF_Issue_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Issue_IssueCategoryID] DEFAULT (0) FOR [IssueCategoryID] ,
   CONSTRAINT [DF_Issue_SubmitID] DEFAULT (0) FOR [SubmitID] ,
   CONSTRAINT [DF_Issue_IssueDate] DEFAULT (0) FOR [IssueDate] ,
   CONSTRAINT [DF_Issue_IssueName] DEFAULT ('') FOR [IssueName] ,
   CONSTRAINT [DF_Issue_SubmittedBy] DEFAULT ('') FOR [SubmittedBy] ,
   CONSTRAINT [DF_Issue_SubmitType] DEFAULT (0) FOR [SubmitType] ,
   CONSTRAINT [DF_Issue_Priority] DEFAULT (0) FOR [Priority] ,
   CONSTRAINT [DF_Issue_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Issue_AssignedTo] DEFAULT ('') FOR [AssignedTo] ,
   CONSTRAINT [DF_Issue_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Issue_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Issue_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_Issue_DueDate] DEFAULT (0) FOR [DueDate] ,
   CONSTRAINT [DF_Issue_DoneDate] DEFAULT (0) FOR [DoneDate] ,
   CONSTRAINT [DF_Issue_Variance] DEFAULT (0) FOR [Variance] ,
   CONSTRAINT [DF_Issue_InputValues] DEFAULT ('') FOR [InputValues] ,
   CONSTRAINT [DF_Issue_Rating] DEFAULT (0) FOR [Rating] ,
   CONSTRAINT [DF_Issue_Outsource] DEFAULT ('') FOR [Outsource]
GO

ALTER TABLE [dbo].[Issue] WITH NOCHECK ADD
   CONSTRAINT [PK_Issue] PRIMARY KEY NONCLUSTERED
   ([IssueID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Issue_CompanyID]
   ON [dbo].[Issue]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO