EXEC [dbo].pts_CheckTable 'Task'
 GO

CREATE TABLE [dbo].[Task] (
   [TaskID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [ProjectID] int NOT NULL ,
   [DependentID] int NOT NULL ,
   [TaskName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Seq] int NOT NULL ,
   [IsMilestone] bit NOT NULL ,
   [EstStartDate] datetime NOT NULL ,
   [ActStartDate] datetime NOT NULL ,
   [VarStartDate] int NOT NULL ,
   [EstEndDate] datetime NOT NULL ,
   [ActEndDate] datetime NOT NULL ,
   [VarEndDate] int NOT NULL ,
   [EstCost] money NOT NULL ,
   [TotCost] money NOT NULL ,
   [VarCost] money NOT NULL ,
   [Cost] money NOT NULL ,
   [Hrs] money NOT NULL ,
   [TotHrs] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Task] WITH NOCHECK ADD
   CONSTRAINT [DF_Task_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Task_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Task_ProjectID] DEFAULT (0) FOR [ProjectID] ,
   CONSTRAINT [DF_Task_DependentID] DEFAULT (0) FOR [DependentID] ,
   CONSTRAINT [DF_Task_TaskName] DEFAULT ('') FOR [TaskName] ,
   CONSTRAINT [DF_Task_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Task_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Task_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Task_IsMilestone] DEFAULT (0) FOR [IsMilestone] ,
   CONSTRAINT [DF_Task_EstStartDate] DEFAULT (0) FOR [EstStartDate] ,
   CONSTRAINT [DF_Task_ActStartDate] DEFAULT (0) FOR [ActStartDate] ,
   CONSTRAINT [DF_Task_VarStartDate] DEFAULT (0) FOR [VarStartDate] ,
   CONSTRAINT [DF_Task_EstEndDate] DEFAULT (0) FOR [EstEndDate] ,
   CONSTRAINT [DF_Task_ActEndDate] DEFAULT (0) FOR [ActEndDate] ,
   CONSTRAINT [DF_Task_VarEndDate] DEFAULT (0) FOR [VarEndDate] ,
   CONSTRAINT [DF_Task_EstCost] DEFAULT (0) FOR [EstCost] ,
   CONSTRAINT [DF_Task_TotCost] DEFAULT (0) FOR [TotCost] ,
   CONSTRAINT [DF_Task_VarCost] DEFAULT (0) FOR [VarCost] ,
   CONSTRAINT [DF_Task_Cost] DEFAULT (0) FOR [Cost] ,
   CONSTRAINT [DF_Task_Hrs] DEFAULT (0) FOR [Hrs] ,
   CONSTRAINT [DF_Task_TotHrs] DEFAULT (0) FOR [TotHrs]
GO

ALTER TABLE [dbo].[Task] WITH NOCHECK ADD
   CONSTRAINT [PK_Task] PRIMARY KEY NONCLUSTERED
   ([TaskID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Task_MemberID]
   ON [dbo].[Task]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Task_ParentID]
   ON [dbo].[Task]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Task_ProjectID]
   ON [dbo].[Task]
   ([ProjectID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO