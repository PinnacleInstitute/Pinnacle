EXEC [dbo].pts_CheckTable 'CompPlan'
 GO

CREATE TABLE [dbo].[CompPlan] (
   [CompPlanID] int IDENTITY (1,1) NOT NULL ,
   [Level] int NOT NULL ,
   [Name] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Bonus1] money NOT NULL ,
   [Bonus2] money NOT NULL ,
   [Bonus3] money NOT NULL ,
   [Bonus4] money NOT NULL ,
   [Bonus5] money NOT NULL ,
   [Bonus6] money NOT NULL ,
   [Override1] money NOT NULL ,
   [Override2] money NOT NULL ,
   [Override3] money NOT NULL ,
   [Override4] money NOT NULL ,
   [Override5] money NOT NULL ,
   [NoPromote] bit NOT NULL ,
   [NoDemote] bit NOT NULL ,
   [QualifyPV] money NOT NULL ,
   [QualifyGV] money NOT NULL ,
   [QualifyBVMonths] int NOT NULL ,
   [QualifyRecruitQty] int NOT NULL ,
   [QualifyRecruitLevel] int NOT NULL ,
   [QualifyRecruitMonths] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CompPlan] WITH NOCHECK ADD
   CONSTRAINT [DF_CompPlan_Level] DEFAULT (0) FOR [Level] ,
   CONSTRAINT [DF_CompPlan_Name] DEFAULT ('') FOR [Name] ,
   CONSTRAINT [DF_CompPlan_Bonus1] DEFAULT (0) FOR [Bonus1] ,
   CONSTRAINT [DF_CompPlan_Bonus2] DEFAULT (0) FOR [Bonus2] ,
   CONSTRAINT [DF_CompPlan_Bonus3] DEFAULT (0) FOR [Bonus3] ,
   CONSTRAINT [DF_CompPlan_Bonus4] DEFAULT (0) FOR [Bonus4] ,
   CONSTRAINT [DF_CompPlan_Bonus5] DEFAULT (0) FOR [Bonus5] ,
   CONSTRAINT [DF_CompPlan_Bonus6] DEFAULT (0) FOR [Bonus6] ,
   CONSTRAINT [DF_CompPlan_Override1] DEFAULT (0) FOR [Override1] ,
   CONSTRAINT [DF_CompPlan_Override2] DEFAULT (0) FOR [Override2] ,
   CONSTRAINT [DF_CompPlan_Override3] DEFAULT (0) FOR [Override3] ,
   CONSTRAINT [DF_CompPlan_Override4] DEFAULT (0) FOR [Override4] ,
   CONSTRAINT [DF_CompPlan_Override5] DEFAULT (0) FOR [Override5] ,
   CONSTRAINT [DF_CompPlan_NoPromote] DEFAULT (0) FOR [NoPromote] ,
   CONSTRAINT [DF_CompPlan_NoDemote] DEFAULT (0) FOR [NoDemote] ,
   CONSTRAINT [DF_CompPlan_QualifyPV] DEFAULT (0) FOR [QualifyPV] ,
   CONSTRAINT [DF_CompPlan_QualifyGV] DEFAULT (0) FOR [QualifyGV] ,
   CONSTRAINT [DF_CompPlan_QualifyBVMonths] DEFAULT (0) FOR [QualifyBVMonths] ,
   CONSTRAINT [DF_CompPlan_QualifyRecruitQty] DEFAULT (0) FOR [QualifyRecruitQty] ,
   CONSTRAINT [DF_CompPlan_QualifyRecruitLevel] DEFAULT (0) FOR [QualifyRecruitLevel] ,
   CONSTRAINT [DF_CompPlan_QualifyRecruitMonths] DEFAULT (0) FOR [QualifyRecruitMonths]
GO

ALTER TABLE [dbo].[CompPlan] WITH NOCHECK ADD
   CONSTRAINT [PK_CompPlan] PRIMARY KEY NONCLUSTERED
   ([CompPlanID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO