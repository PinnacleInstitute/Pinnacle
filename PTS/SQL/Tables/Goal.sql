EXEC [dbo].pts_CheckTable 'Goal'
 GO

CREATE TABLE [dbo].[Goal] (
   [GoalID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [AssignID] int NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ProspectID] int NOT NULL ,
   [GoalName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [GoalType] int NOT NULL ,
   [Priority] int NOT NULL ,
   [Status] int NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CommitDate] datetime NOT NULL ,
   [CompleteDate] datetime NOT NULL ,
   [Variance] int NOT NULL ,
   [RemindDate] datetime NOT NULL ,
   [Template] int NOT NULL ,
   [Children] int NOT NULL ,
   [Qty] int NOT NULL ,
   [ActQty] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Goal] WITH NOCHECK ADD
   CONSTRAINT [DF_Goal_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Goal_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Goal_AssignID] DEFAULT (0) FOR [AssignID] ,
   CONSTRAINT [DF_Goal_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Goal_ProspectID] DEFAULT (0) FOR [ProspectID] ,
   CONSTRAINT [DF_Goal_GoalName] DEFAULT ('') FOR [GoalName] ,
   CONSTRAINT [DF_Goal_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Goal_GoalType] DEFAULT (0) FOR [GoalType] ,
   CONSTRAINT [DF_Goal_Priority] DEFAULT (0) FOR [Priority] ,
   CONSTRAINT [DF_Goal_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Goal_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_Goal_CommitDate] DEFAULT (0) FOR [CommitDate] ,
   CONSTRAINT [DF_Goal_CompleteDate] DEFAULT (0) FOR [CompleteDate] ,
   CONSTRAINT [DF_Goal_Variance] DEFAULT (0) FOR [Variance] ,
   CONSTRAINT [DF_Goal_RemindDate] DEFAULT (0) FOR [RemindDate] ,
   CONSTRAINT [DF_Goal_Template] DEFAULT (0) FOR [Template] ,
   CONSTRAINT [DF_Goal_Children] DEFAULT (0) FOR [Children] ,
   CONSTRAINT [DF_Goal_Qty] DEFAULT (0) FOR [Qty] ,
   CONSTRAINT [DF_Goal_ActQty] DEFAULT (0) FOR [ActQty]
GO

ALTER TABLE [dbo].[Goal] WITH NOCHECK ADD
   CONSTRAINT [PK_Goal] PRIMARY KEY NONCLUSTERED
   ([GoalID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_MemberID]
   ON [dbo].[Goal]
   ([MemberID], [CommitDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_Template]
   ON [dbo].[Goal]
   ([MemberID], [Template])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_ParentID]
   ON [dbo].[Goal]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_ProspectID]
   ON [dbo].[Goal]
   ([ProspectID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_CompanyID]
   ON [dbo].[Goal]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Goal_RemindDate]
   ON [dbo].[Goal]
   ([RemindDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO