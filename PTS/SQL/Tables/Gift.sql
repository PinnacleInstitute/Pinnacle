EXEC [dbo].pts_CheckTable 'Gift'
 GO

CREATE TABLE [dbo].[Gift] (
   [GiftID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [PaymentID] int NOT NULL ,
   [Member2ID] int NOT NULL ,
   [GiftDate] datetime NOT NULL ,
   [ActiveDate] datetime NOT NULL ,
   [Amount] money NOT NULL ,
   [Purpose] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Notes] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Gift] WITH NOCHECK ADD
   CONSTRAINT [DF_Gift_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Gift_PaymentID] DEFAULT (0) FOR [PaymentID] ,
   CONSTRAINT [DF_Gift_Member2ID] DEFAULT (0) FOR [Member2ID] ,
   CONSTRAINT [DF_Gift_GiftDate] DEFAULT (0) FOR [GiftDate] ,
   CONSTRAINT [DF_Gift_ActiveDate] DEFAULT (0) FOR [ActiveDate] ,
   CONSTRAINT [DF_Gift_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Gift_Purpose] DEFAULT ('') FOR [Purpose] ,
   CONSTRAINT [DF_Gift_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[Gift] WITH NOCHECK ADD
   CONSTRAINT [PK_Gift] PRIMARY KEY NONCLUSTERED
   ([GiftID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Gift_MemberID]
   ON [dbo].[Gift]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Gift_Member2ID]
   ON [dbo].[Gift]
   ([Member2ID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Gift_PaymentID]
   ON [dbo].[Gift]
   ([PaymentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO