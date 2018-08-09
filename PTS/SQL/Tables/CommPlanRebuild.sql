EXEC [dbo].pts_CheckTableRebuild 'CommPlan'
 GO

ALTER TABLE [dbo].[CommPlan] WITH NOCHECK ADD
   CONSTRAINT [DF_CommPlan_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_CommPlan_CommPlanName] DEFAULT ('') FOR [CommPlanName] ,
   CONSTRAINT [DF_CommPlan_CommPlanNo] DEFAULT (0) FOR [CommPlanNo]
GO

ALTER TABLE [dbo].[CommPlan] WITH NOCHECK ADD
   CONSTRAINT [PK_CommPlan] PRIMARY KEY NONCLUSTERED
   ([CommPlanID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CommPlan_CompanyID]
   ON [dbo].[CommPlan]
   ([CompanyID], [CommPlanNo])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO