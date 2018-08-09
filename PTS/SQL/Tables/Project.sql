EXEC [dbo].pts_CheckTable 'Project'
 GO

CREATE TABLE [dbo].[Project] (
   [ProjectID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [ForumID] int NOT NULL ,
   [ProjectTypeID] int NOT NULL ,
   [ProjectName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Seq] int NOT NULL ,
   [IsChat] bit NOT NULL ,
   [IsForum] bit NOT NULL ,
   [Secure] int NOT NULL ,
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
   [TotHrs] money NOT NULL ,
   [Hierarchy] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [RefType] int NOT NULL ,
   [RefID] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Project] WITH NOCHECK ADD
   CONSTRAINT [DF_Project_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Project_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Project_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Project_ForumID] DEFAULT (0) FOR [ForumID] ,
   CONSTRAINT [DF_Project_ProjectTypeID] DEFAULT (0) FOR [ProjectTypeID] ,
   CONSTRAINT [DF_Project_ProjectName] DEFAULT ('') FOR [ProjectName] ,
   CONSTRAINT [DF_Project_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Project_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Project_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Project_IsChat] DEFAULT (0) FOR [IsChat] ,
   CONSTRAINT [DF_Project_IsForum] DEFAULT (0) FOR [IsForum] ,
   CONSTRAINT [DF_Project_Secure] DEFAULT (0) FOR [Secure] ,
   CONSTRAINT [DF_Project_EstStartDate] DEFAULT (0) FOR [EstStartDate] ,
   CONSTRAINT [DF_Project_ActStartDate] DEFAULT (0) FOR [ActStartDate] ,
   CONSTRAINT [DF_Project_VarStartDate] DEFAULT (0) FOR [VarStartDate] ,
   CONSTRAINT [DF_Project_EstEndDate] DEFAULT (0) FOR [EstEndDate] ,
   CONSTRAINT [DF_Project_ActEndDate] DEFAULT (0) FOR [ActEndDate] ,
   CONSTRAINT [DF_Project_VarEndDate] DEFAULT (0) FOR [VarEndDate] ,
   CONSTRAINT [DF_Project_EstCost] DEFAULT (0) FOR [EstCost] ,
   CONSTRAINT [DF_Project_TotCost] DEFAULT (0) FOR [TotCost] ,
   CONSTRAINT [DF_Project_VarCost] DEFAULT (0) FOR [VarCost] ,
   CONSTRAINT [DF_Project_Cost] DEFAULT (0) FOR [Cost] ,
   CONSTRAINT [DF_Project_Hrs] DEFAULT (0) FOR [Hrs] ,
   CONSTRAINT [DF_Project_TotHrs] DEFAULT (0) FOR [TotHrs] ,
   CONSTRAINT [DF_Project_Hierarchy] DEFAULT ('') FOR [Hierarchy] ,
   CONSTRAINT [DF_Project_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_Project_RefType] DEFAULT (0) FOR [RefType] ,
   CONSTRAINT [DF_Project_RefID] DEFAULT (0) FOR [RefID]
GO

ALTER TABLE [dbo].[Project] WITH NOCHECK ADD
   CONSTRAINT [PK_Project] PRIMARY KEY NONCLUSTERED
   ([ProjectID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Project_MemberID]
   ON [dbo].[Project]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Project_ParentID]
   ON [dbo].[Project]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Project_CompanyID]
   ON [dbo].[Project]
   ([CompanyID], [Hierarchy])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO