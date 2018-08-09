EXEC [dbo].pts_CheckTableRebuild 'SalesMember'
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