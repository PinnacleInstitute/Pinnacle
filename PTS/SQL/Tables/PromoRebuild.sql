EXEC [dbo].pts_CheckTableRebuild 'Promo'
 GO

ALTER TABLE [dbo].[Promo] WITH NOCHECK ADD
   CONSTRAINT [DF_Promo_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Promo_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Promo_PromoName] DEFAULT ('') FOR [PromoName] ,
   CONSTRAINT [DF_Promo_FromEmail] DEFAULT ('') FOR [FromEmail] ,
   CONSTRAINT [DF_Promo_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Promo_Message] DEFAULT ('') FOR [Message] ,
   CONSTRAINT [DF_Promo_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Promo_TargetArea] DEFAULT (0) FOR [TargetArea] ,
   CONSTRAINT [DF_Promo_TargetType] DEFAULT (0) FOR [TargetType] ,
   CONSTRAINT [DF_Promo_TargetDays] DEFAULT (0) FOR [TargetDays] ,
   CONSTRAINT [DF_Promo_Target] DEFAULT ('') FOR [Target] ,
   CONSTRAINT [DF_Promo_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Promo_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Promo_SendDate] DEFAULT (0) FOR [SendDate] ,
   CONSTRAINT [DF_Promo_Msgs] DEFAULT (0) FOR [Msgs] ,
   CONSTRAINT [DF_Promo_TestEmail] DEFAULT ('') FOR [TestEmail]
GO

ALTER TABLE [dbo].[Promo] WITH NOCHECK ADD
   CONSTRAINT [PK_Promo] PRIMARY KEY NONCLUSTERED
   ([PromoID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Promo_MerchantID]
   ON [dbo].[Promo]
   ([MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO