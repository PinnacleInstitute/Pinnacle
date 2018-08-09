EXEC [dbo].pts_CheckTable 'SalesArea'
 GO

CREATE TABLE [dbo].[SalesArea] (
   [SalesAreaID] int IDENTITY (1,1) NOT NULL ,
   [ParentID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [SalesAreaName] varchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [StatusDate] datetime NOT NULL ,
   [Level] int NOT NULL ,
   [Density] int NOT NULL ,
   [Population] int NOT NULL ,
   [FTE] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesArea] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesArea_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_SalesArea_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_SalesArea_SalesAreaName] DEFAULT ('') FOR [SalesAreaName] ,
   CONSTRAINT [DF_SalesArea_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesArea_StatusDate] DEFAULT (0) FOR [StatusDate] ,
   CONSTRAINT [DF_SalesArea_Level] DEFAULT (0) FOR [Level] ,
   CONSTRAINT [DF_SalesArea_Density] DEFAULT (0) FOR [Density] ,
   CONSTRAINT [DF_SalesArea_Population] DEFAULT (0) FOR [Population] ,
   CONSTRAINT [DF_SalesArea_FTE] DEFAULT (0) FOR [FTE]
GO

ALTER TABLE [dbo].[SalesArea] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesArea] PRIMARY KEY NONCLUSTERED
   ([SalesAreaID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesArea_ParentID]
   ON [dbo].[SalesArea]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO