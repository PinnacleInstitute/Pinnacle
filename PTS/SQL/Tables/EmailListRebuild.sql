EXEC [dbo].pts_CheckTableRebuild 'EmailList'
 GO

ALTER TABLE [dbo].[EmailList] WITH NOCHECK ADD
   CONSTRAINT [DF_EmailList_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_EmailList_EmailSourceID] DEFAULT (0) FOR [EmailSourceID] ,
   CONSTRAINT [DF_EmailList_EmailListName] DEFAULT ('') FOR [EmailListName] ,
   CONSTRAINT [DF_EmailList_SourceType] DEFAULT (0) FOR [SourceType] ,
   CONSTRAINT [DF_EmailList_CustomID] DEFAULT (0) FOR [CustomID] ,
   CONSTRAINT [DF_EmailList_Param1] DEFAULT ('') FOR [Param1] ,
   CONSTRAINT [DF_EmailList_Param2] DEFAULT ('') FOR [Param2] ,
   CONSTRAINT [DF_EmailList_Param3] DEFAULT ('') FOR [Param3] ,
   CONSTRAINT [DF_EmailList_Param4] DEFAULT ('') FOR [Param4] ,
   CONSTRAINT [DF_EmailList_Param5] DEFAULT ('') FOR [Param5] ,
   CONSTRAINT [DF_EmailList_Unsubscribe] DEFAULT (0) FOR [Unsubscribe] ,
   CONSTRAINT [DF_EmailList_Query] DEFAULT ('') FOR [Query]
GO

ALTER TABLE [dbo].[EmailList] WITH NOCHECK ADD
   CONSTRAINT [PK_EmailList] PRIMARY KEY NONCLUSTERED
   ([EmailListID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_EmailList_CompanyID]
   ON [dbo].[EmailList]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO