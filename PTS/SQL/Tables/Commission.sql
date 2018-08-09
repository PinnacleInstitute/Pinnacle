EXEC [dbo].pts_CheckTable 'Commission'
 GO

CREATE TABLE [dbo].[Commission] (
   [CommissionID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [OwnerType] int NOT NULL ,
   [OwnerID] int NOT NULL ,
   [PayoutID] int NOT NULL ,
   [RefID] int NOT NULL ,
   [CommDate] datetime NOT NULL ,
   [Status] int NOT NULL ,
   [CommType] int NOT NULL ,
   [Amount] money NOT NULL ,
   [Total] money NOT NULL ,
   [Charge] money NOT NULL ,
   [Description] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Notes] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Show] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Commission] WITH NOCHECK ADD
   CONSTRAINT [DF_Commission_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Commission_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Commission_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Commission_PayoutID] DEFAULT (0) FOR [PayoutID] ,
   CONSTRAINT [DF_Commission_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Commission_CommDate] DEFAULT (0) FOR [CommDate] ,
   CONSTRAINT [DF_Commission_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Commission_CommType] DEFAULT (0) FOR [CommType] ,
   CONSTRAINT [DF_Commission_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Commission_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_Commission_Charge] DEFAULT (0) FOR [Charge] ,
   CONSTRAINT [DF_Commission_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Commission_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Commission_Show] DEFAULT (0) FOR [Show]
GO

ALTER TABLE [dbo].[Commission] WITH NOCHECK ADD
   CONSTRAINT [PK_Commission] PRIMARY KEY NONCLUSTERED
   ([CommissionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Commission_Owner]
   ON [dbo].[Commission]
   ([OwnerType], [OwnerID], [CommDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Commission_Payout]
   ON [dbo].[Commission]
   ([PayoutID], [CommType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Commission_Company]
   ON [dbo].[Commission]
   ([CompanyID], [CommDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO