EXEC [dbo].pts_CheckTable 'CommPlan'
 GO

CREATE TABLE [dbo].[CommPlan] (
   [CommPlanID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [CommPlanName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CommPlanNo] int NOT NULL 
   ) ON [PRIMARY]
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