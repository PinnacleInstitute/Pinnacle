EXEC [dbo].pts_CheckTableRebuild 'Contest'
 GO

ALTER TABLE [dbo].[Contest] WITH NOCHECK ADD
   CONSTRAINT [DF_Contest_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Contest_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Contest_ContestName] DEFAULT ('') FOR [ContestName] ,
   CONSTRAINT [DF_Contest_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Contest_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Contest_Metric] DEFAULT (0) FOR [Metric] ,
   CONSTRAINT [DF_Contest_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Contest_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Contest_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_Contest_Custom1] DEFAULT (0) FOR [Custom1] ,
   CONSTRAINT [DF_Contest_Custom2] DEFAULT (0) FOR [Custom2] ,
   CONSTRAINT [DF_Contest_Custom3] DEFAULT (0) FOR [Custom3] ,
   CONSTRAINT [DF_Contest_Custom4] DEFAULT (0) FOR [Custom4] ,
   CONSTRAINT [DF_Contest_Custom5] DEFAULT (0) FOR [Custom5]
GO

ALTER TABLE [dbo].[Contest] WITH NOCHECK ADD
   CONSTRAINT [PK_Contest] PRIMARY KEY NONCLUSTERED
   ([ContestID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Contest_CompanyID]
   ON [dbo].[Contest]
   ([CompanyID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO