EXEC [dbo].pts_CheckTableRebuild 'Metric'
 GO

ALTER TABLE [dbo].[Metric] WITH NOCHECK ADD
   CONSTRAINT [DF_Metric_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Metric_MetricTypeID] DEFAULT (0) FOR [MetricTypeID] ,
   CONSTRAINT [DF_Metric_IsGoal] DEFAULT (0) FOR [IsGoal] ,
   CONSTRAINT [DF_Metric_MetricDate] DEFAULT (0) FOR [MetricDate] ,
   CONSTRAINT [DF_Metric_Qty] DEFAULT (0) FOR [Qty] ,
   CONSTRAINT [DF_Metric_Note] DEFAULT ('') FOR [Note] ,
   CONSTRAINT [DF_Metric_InputValues] DEFAULT ('') FOR [InputValues]
GO

ALTER TABLE [dbo].[Metric] WITH NOCHECK ADD
   CONSTRAINT [PK_Metric] PRIMARY KEY NONCLUSTERED
   ([MetricID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Metric_MemberID]
   ON [dbo].[Metric]
   ([MemberID], [IsGoal], [MetricTypeID], [MetricDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Metric_MetricDate]
   ON [dbo].[Metric]
   ([MemberID], [IsGoal], [MetricDate], [MetricTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO