EXEC [dbo].pts_CheckTable 'SalesMember'
 GO

CREATE TABLE [dbo].[SalesMember] (
   [SalesMemberID] int IDENTITY (1,1) NOT NULL ,
   [SalesAreaID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [Status] int NOT NULL ,
   [StatusDate] datetime NOT NULL ,
   [FTE] int NOT NULL ,
   [Assignment] varchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesMember] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesMember_SalesAreaID] DEFAULT (0) FOR [SalesAreaID] ,
   CONSTRAINT [DF_SalesMember_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_SalesMember_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesMember_StatusDate] DEFAULT (0) FOR [StatusDate] ,
   CONSTRAINT [DF_SalesMember_FTE] DEFAULT (0) FOR [FTE] ,
   CONSTRAINT [DF_SalesMember_Assignment] DEFAULT ('') FOR [Assignment]
GO

ALTER TABLE [dbo].[SalesMember] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesMember] PRIMARY KEY NONCLUSTERED
   ([SalesMemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesMember_SalesAreaID]
   ON [dbo].[SalesMember]
   ([SalesAreaID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesMember_MemberID]
   ON [dbo].[SalesMember]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO