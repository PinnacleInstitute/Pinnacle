EXEC [dbo].pts_CheckTable 'Cash'
 GO

CREATE TABLE [dbo].[Cash] (
   [CashID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [RefID] int NOT NULL ,
   [CashDate] datetime NOT NULL ,
   [CashType] int NOT NULL ,
   [Amount] money NOT NULL ,
   [Note] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Cash] WITH NOCHECK ADD
   CONSTRAINT [DF_Cash_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Cash_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Cash_CashDate] DEFAULT (0) FOR [CashDate] ,
   CONSTRAINT [DF_Cash_CashType] DEFAULT (0) FOR [CashType] ,
   CONSTRAINT [DF_Cash_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Cash_Note] DEFAULT ('') FOR [Note]
GO

ALTER TABLE [dbo].[Cash] WITH NOCHECK ADD
   CONSTRAINT [PK_Cash] PRIMARY KEY NONCLUSTERED
   ([CashID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Cash_MemberID]
   ON [dbo].[Cash]
   ([MemberID], [CashDate], [CashType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO