EXEC [dbo].pts_CheckTableRebuild 'Exchange'
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