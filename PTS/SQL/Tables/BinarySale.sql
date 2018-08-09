EXEC [dbo].pts_CheckTable 'BinarySale'
 GO

CREATE TABLE [dbo].[BinarySale] (
   [BinarySaleID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [RefID] int NOT NULL ,
   [SaleDate] datetime NOT NULL ,
   [SaleType] int NOT NULL ,
   [Amount] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[BinarySale] WITH NOCHECK ADD
   CONSTRAINT [DF_BinarySale_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_BinarySale_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_BinarySale_SaleDate] DEFAULT (0) FOR [SaleDate] ,
   CONSTRAINT [DF_BinarySale_SaleType] DEFAULT (0) FOR [SaleType] ,
   CONSTRAINT [DF_BinarySale_Amount] DEFAULT (0) FOR [Amount]
GO

ALTER TABLE [dbo].[BinarySale] WITH NOCHECK ADD
   CONSTRAINT [PK_BinarySale] PRIMARY KEY NONCLUSTERED
   ([BinarySaleID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BinarySale_MemberID]
   ON [dbo].[BinarySale]
   ([MemberID], [SaleDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BinarySale_RefID]
   ON [dbo].[BinarySale]
   ([RefID], [SaleType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO