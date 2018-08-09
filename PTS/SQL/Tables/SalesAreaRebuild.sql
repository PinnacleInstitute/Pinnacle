EXEC [dbo].pts_CheckTableRebuild 'SalesArea'
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