EXEC [dbo].pts_CheckTable 'Pool'
 GO

CREATE TABLE [dbo].[Pool] (
   [PoolID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [PoolDate] datetime NOT NULL ,
   [PoolType] int NOT NULL ,
   [Amount] money NOT NULL ,
   [Distributed] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Pool] WITH NOCHECK ADD
   CONSTRAINT [DF_Pool_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Pool_PoolDate] DEFAULT (0) FOR [PoolDate] ,
   CONSTRAINT [DF_Pool_PoolType] DEFAULT (0) FOR [PoolType] ,
   CONSTRAINT [DF_Pool_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Pool_Distributed] DEFAULT (0) FOR [Distributed]
GO

ALTER TABLE [dbo].[Pool] WITH NOCHECK ADD
   CONSTRAINT [PK_Pool] PRIMARY KEY NONCLUSTERED
   ([PoolID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Pool_MemberID]
   ON [dbo].[Pool]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO