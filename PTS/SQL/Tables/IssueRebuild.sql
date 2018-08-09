EXEC [dbo].pts_CheckTableRebuild 'Issue'
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