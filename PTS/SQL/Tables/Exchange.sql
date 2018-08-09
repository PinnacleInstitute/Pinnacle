EXEC [dbo].pts_CheckTable 'Exchange'
 GO

CREATE TABLE [dbo].[Exchange] (
   [ExchangeID] int IDENTITY (1,1) NOT NULL ,
   [CountryID] int NOT NULL ,
   [ExchangeName] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Skype] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Street1] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street2] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ActiveDate] datetime NOT NULL ,
   [Payment] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Exchange] WITH NOCHECK ADD
   CONSTRAINT [DF_Exchange_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Exchange_ExchangeName] DEFAULT ('') FOR [ExchangeName] ,
   CONSTRAINT [DF_Exchange_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Exchange_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Exchange_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Exchange_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Exchange_Skype] DEFAULT ('') FOR [Skype] ,
   CONSTRAINT [DF_Exchange_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Exchange_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Exchange_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Exchange_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Exchange_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Exchange_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Exchange_ActiveDate] DEFAULT (0) FOR [ActiveDate] ,
   CONSTRAINT [DF_Exchange_Payment] DEFAULT ('') FOR [Payment]
GO

ALTER TABLE [dbo].[Exchange] WITH NOCHECK ADD
   CONSTRAINT [PK_Exchange] PRIMARY KEY NONCLUSTERED
   ([ExchangeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO