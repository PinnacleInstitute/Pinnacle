EXEC [dbo].pts_CheckTableRebuild 'Merchant'
 GO

ALTER TABLE [dbo].[Merchant] WITH NOCHECK ADD
   CONSTRAINT [DF_Merchant_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Merchant_BillingID] DEFAULT (0) FOR [BillingID] ,
   CONSTRAINT [DF_Merchant_PayoutID] DEFAULT (0) FOR [PayoutID] ,
   CONSTRAINT [DF_Merchant_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Merchant_SweepID] DEFAULT (0) FOR [SweepID] ,
   CONSTRAINT [DF_Merchant_MerchantName] DEFAULT ('') FOR [MerchantName] ,
   CONSTRAINT [DF_Merchant_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Merchant_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Merchant_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Merchant_Email2] DEFAULT ('') FOR [Email2] ,
   CONSTRAINT [DF_Merchant_Email3] DEFAULT ('') FOR [Email3] ,
   CONSTRAINT [DF_Merchant_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Merchant_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Merchant_Password] DEFAULT ('') FOR [Password] ,
   CONSTRAINT [DF_Merchant_Password2] DEFAULT ('') FOR [Password2] ,
   CONSTRAINT [DF_Merchant_Password3] DEFAULT ('') FOR [Password3] ,
   CONSTRAINT [DF_Merchant_Password4] DEFAULT ('') FOR [Password4] ,
   CONSTRAINT [DF_Merchant_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Merchant_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Merchant_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Merchant_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Merchant_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Merchant_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Merchant_Referrals] DEFAULT (0) FOR [Referrals] ,
   CONSTRAINT [DF_Merchant_Referrals2] DEFAULT (0) FOR [Referrals2] ,
   CONSTRAINT [DF_Merchant_VisitDate] DEFAULT (0) FOR [VisitDate] ,
   CONSTRAINT [DF_Merchant_IsOrg] DEFAULT (0) FOR [IsOrg] ,
   CONSTRAINT [DF_Merchant_IsAwards] DEFAULT (0) FOR [IsAwards] ,
   CONSTRAINT [DF_Merchant_EnrollDate] DEFAULT (0) FOR [EnrollDate] ,
   CONSTRAINT [DF_Merchant_BillDate] DEFAULT (0) FOR [BillDate] ,
   CONSTRAINT [DF_Merchant_BillDays] DEFAULT (0) FOR [BillDays] ,
   CONSTRAINT [DF_Merchant_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_Merchant_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Merchant_Terms] DEFAULT ('') FOR [Terms] ,
   CONSTRAINT [DF_Merchant_Options] DEFAULT ('') FOR [Options] ,
   CONSTRAINT [DF_Merchant_StoreOptions] DEFAULT ('') FOR [StoreOptions] ,
   CONSTRAINT [DF_Merchant_Colors] DEFAULT ('') FOR [Colors] ,
   CONSTRAINT [DF_Merchant_Rating] DEFAULT (0) FOR [Rating] ,
   CONSTRAINT [DF_Merchant_CurrencyCode] DEFAULT ('') FOR [CurrencyCode] ,
   CONSTRAINT [DF_Merchant_Processor] DEFAULT (0) FOR [Processor] ,
   CONSTRAINT [DF_Merchant_Payment] DEFAULT ('') FOR [Payment] ,
   CONSTRAINT [DF_Merchant_UserKey] DEFAULT ('') FOR [UserKey] ,
   CONSTRAINT [DF_Merchant_UserKey3] DEFAULT ('') FOR [UserKey3] ,
   CONSTRAINT [DF_Merchant_UserKey4] DEFAULT ('') FOR [UserKey4] ,
   CONSTRAINT [DF_Merchant_UserCode] DEFAULT ('') FOR [UserCode] ,
   CONSTRAINT [DF_Merchant_Access] DEFAULT ('') FOR [Access] ,
   CONSTRAINT [DF_Merchant_PromoLimit] DEFAULT (0) FOR [PromoLimit] ,
   CONSTRAINT [DF_Merchant_SweepRate] DEFAULT (0) FOR [SweepRate] ,
   CONSTRAINT [DF_Merchant_TimeZone] DEFAULT (0) FOR [TimeZone] ,
   CONSTRAINT [DF_Merchant_GeoCode] DEFAULT ('') FOR [GeoCode] ,
   CONSTRAINT [DF_Merchant_ReferRate] DEFAULT (0) FOR [ReferRate]
GO

ALTER TABLE [dbo].[Merchant] WITH NOCHECK ADD
   CONSTRAINT [PK_Merchant] PRIMARY KEY NONCLUSTERED
   ([MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Merchant_MemberID]
   ON [dbo].[Merchant]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Merchant_Email]
   ON [dbo].[Merchant]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Merchant_Zip]
   ON [dbo].[Merchant]
   ([CountryID], [Zip])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Merchant_State]
   ON [dbo].[Merchant]
   ([State])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Merchant_City]
   ON [dbo].[Merchant]
   ([City])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO