EXEC [dbo].pts_CheckTableRebuild 'IssueCategory'
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