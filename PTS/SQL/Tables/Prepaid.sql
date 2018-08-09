EXEC [dbo].pts_CheckTable 'Prepaid'
 GO

CREATE TABLE [dbo].[Prepaid] (
   [PrepaidID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [RefID] int NOT NULL ,
   [PayDate] datetime NOT NULL ,
   [PayType] int NOT NULL ,
   [Amount] money NOT NULL ,
   [Note] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [BV] money NOT NULL ,
   [Bonus] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Prepaid] WITH NOCHECK ADD
   CONSTRAINT [DF_Prepaid_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Prepaid_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Prepaid_PayDate] DEFAULT (0) FOR [PayDate] ,
   CONSTRAINT [DF_Prepaid_PayType] DEFAULT (0) FOR [PayType] ,
   CONSTRAINT [DF_Prepaid_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Prepaid_Note] DEFAULT ('') FOR [Note] ,
   CONSTRAINT [DF_Prepaid_BV] DEFAULT (0) FOR [BV] ,
   CONSTRAINT [DF_Prepaid_Bonus] DEFAULT (0) FOR [Bonus]
GO

ALTER TABLE [dbo].[Prepaid] WITH NOCHECK ADD
   CONSTRAINT [PK_Prepaid] PRIMARY KEY NONCLUSTERED
   ([PrepaidID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Prepaid_MemberID]
   ON [dbo].[Prepaid]
   ([MemberID], [PayDate], [PayType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO