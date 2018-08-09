EXEC [dbo].pts_CheckTableRebuild 'MetricType'
 GO

ALTER TABLE [dbo].[MetricType] WITH NOCHECK ADD
   CONSTRAINT [DF_MetricType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_MetricType_GroupID] DEFAULT (0) FOR [GroupID] ,
   CONSTRAINT [DF_MetricType_MetricTypeName] DEFAULT ('') FOR [MetricTypeName] ,
   CONSTRAINT [DF_MetricType_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_MetricType_Pts] DEFAULT (0) FOR [Pts] ,
   CONSTRAINT [DF_MetricType_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_MetricType_IsResult] DEFAULT (0) FOR [IsResult] ,
   CONSTRAINT [DF_MetricType_IsLeader] DEFAULT (0) FOR [IsLeader] ,
   CONSTRAINT [DF_MetricType_IsQty] DEFAULT (0) FOR [IsQty] ,
   CONSTRAINT [DF_MetricType_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_MetricType_Required] DEFAULT ('') FOR [Required] ,
   CONSTRAINT [DF_MetricType_InputOptions] DEFAULT ('') FOR [InputOptions] ,
   CONSTRAINT [DF_MetricType_AutoEvent] DEFAULT (0) FOR [AutoEvent]
GO

ALTER TABLE [dbo].[MetricType] WITH NOCHECK ADD
   CONSTRAINT [PK_MetricType] PRIMARY KEY NONCLUSTERED
   ([MetricTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MetricType_CompanyID]
   ON [dbo].[MetricType]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MetricType_GroupID]
   ON [dbo].[MetricType]
   ([GroupID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO