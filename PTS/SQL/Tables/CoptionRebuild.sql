EXEC [dbo].pts_CheckTableRebuild 'Coption'
 GO

ALTER TABLE [dbo].[Coption] WITH NOCHECK ADD
   CONSTRAINT [DF_Coption_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Coption_InitPrice] DEFAULT (0) FOR [InitPrice] ,
   CONSTRAINT [DF_Coption_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_Coption_Price2] DEFAULT (0) FOR [Price2] ,
   CONSTRAINT [DF_Coption_Price3] DEFAULT (0) FOR [Price3] ,
   CONSTRAINT [DF_Coption_Discount] DEFAULT (0) FOR [Discount] ,
   CONSTRAINT [DF_Coption_Retail] DEFAULT (0) FOR [Retail] ,
   CONSTRAINT [DF_Coption_Retail2] DEFAULT (0) FOR [Retail2] ,
   CONSTRAINT [DF_Coption_Retail3] DEFAULT (0) FOR [Retail3] ,
   CONSTRAINT [DF_Coption_BusPrice] DEFAULT (0) FOR [BusPrice] ,
   CONSTRAINT [DF_Coption_BusRetail] DEFAULT (0) FOR [BusRetail] ,
   CONSTRAINT [DF_Coption_BusAccts] DEFAULT (0) FOR [BusAccts] ,
   CONSTRAINT [DF_Coption_BusAcctPrice] DEFAULT (0) FOR [BusAcctPrice] ,
   CONSTRAINT [DF_Coption_BusAcctRetail] DEFAULT (0) FOR [BusAcctRetail] ,
   CONSTRAINT [DF_Coption_IsCatalog] DEFAULT (0) FOR [IsCatalog] ,
   CONSTRAINT [DF_Coption_IsDiscount] DEFAULT (0) FOR [IsDiscount] ,
   CONSTRAINT [DF_Coption_Billing] DEFAULT (0) FOR [Billing] ,
   CONSTRAINT [DF_Coption_CommRate] DEFAULT (0) FOR [CommRate] ,
   CONSTRAINT [DF_Coption_PromoCode] DEFAULT (0) FOR [PromoCode] ,
   CONSTRAINT [DF_Coption_AccessLimit] DEFAULT ('') FOR [AccessLimit] ,
   CONSTRAINT [DF_Coption_QuizLimit] DEFAULT (0) FOR [QuizLimit] ,
   CONSTRAINT [DF_Coption_MemberLimit] DEFAULT (0) FOR [MemberLimit] ,
   CONSTRAINT [DF_Coption_TrialDays] DEFAULT (0) FOR [TrialDays] ,
   CONSTRAINT [DF_Coption_IsTrialPayment] DEFAULT (0) FOR [IsTrialPayment] ,
   CONSTRAINT [DF_Coption_IsSignIn] DEFAULT (0) FOR [IsSignIn] ,
   CONSTRAINT [DF_Coption_IsJoinNow] DEFAULT (0) FOR [IsJoinNow] ,
   CONSTRAINT [DF_Coption_IsNewEmail] DEFAULT (0) FOR [IsNewEmail] ,
   CONSTRAINT [DF_Coption_IsBusAcct] DEFAULT (0) FOR [IsBusAcct] ,
   CONSTRAINT [DF_Coption_IsFree] DEFAULT (0) FOR [IsFree] ,
   CONSTRAINT [DF_Coption_RefName] DEFAULT ('') FOR [RefName] ,
   CONSTRAINT [DF_Coption_NewMemberOrgs] DEFAULT ('') FOR [NewMemberOrgs] ,
   CONSTRAINT [DF_Coption_TBPage] DEFAULT ('') FOR [TBPage] ,
   CONSTRAINT [DF_Coption_Languages] DEFAULT ('') FOR [Languages] ,
   CONSTRAINT [DF_Coption_UploadURL] DEFAULT ('') FOR [UploadURL] ,
   CONSTRAINT [DF_Coption_SetupFee] DEFAULT (0) FOR [SetupFee] ,
   CONSTRAINT [DF_Coption_IsSalesDefault] DEFAULT (0) FOR [IsSalesDefault] ,
   CONSTRAINT [DF_Coption_ProjectsDefault] DEFAULT (0) FOR [ProjectsDefault] ,
   CONSTRAINT [DF_Coption_DocSizeLimit] DEFAULT (0) FOR [DocSizeLimit] ,
   CONSTRAINT [DF_Coption_FreeOptions] DEFAULT ('') FOR [FreeOptions] ,
   CONSTRAINT [DF_Coption_EasyOptions] DEFAULT ('') FOR [EasyOptions] ,
   CONSTRAINT [DF_Coption_Options] DEFAULT ('') FOR [Options] ,
   CONSTRAINT [DF_Coption_Options2] DEFAULT ('') FOR [Options2] ,
   CONSTRAINT [DF_Coption_Options3] DEFAULT ('') FOR [Options3] ,
   CONSTRAINT [DF_Coption_Options4] DEFAULT ('') FOR [Options4] ,
   CONSTRAINT [DF_Coption_Options5] DEFAULT ('') FOR [Options5] ,
   CONSTRAINT [DF_Coption_Options6] DEFAULT ('') FOR [Options6] ,
   CONSTRAINT [DF_Coption_Options7] DEFAULT ('') FOR [Options7] ,
   CONSTRAINT [DF_Coption_Options8] DEFAULT ('') FOR [Options8] ,
   CONSTRAINT [DF_Coption_FreeName] DEFAULT ('') FOR [FreeName] ,
   CONSTRAINT [DF_Coption_PaidName] DEFAULT ('') FOR [PaidName] ,
   CONSTRAINT [DF_Coption_PaidName2] DEFAULT ('') FOR [PaidName2] ,
   CONSTRAINT [DF_Coption_PaidName3] DEFAULT ('') FOR [PaidName3] ,
   CONSTRAINT [DF_Coption_Identify] DEFAULT (0) FOR [Identify] ,
   CONSTRAINT [DF_Coption_Identification] DEFAULT ('') FOR [Identification] ,
   CONSTRAINT [DF_Coption_MerchantCardType] DEFAULT (0) FOR [MerchantCardType] ,
   CONSTRAINT [DF_Coption_MerchantCheckType] DEFAULT (0) FOR [MerchantCheckType] ,
   CONSTRAINT [DF_Coption_MerchantCardAcct] DEFAULT ('') FOR [MerchantCardAcct] ,
   CONSTRAINT [DF_Coption_MerchantCheckAcct] DEFAULT ('') FOR [MerchantCheckAcct] ,
   CONSTRAINT [DF_Coption_WalletType] DEFAULT ('') FOR [WalletType] ,
   CONSTRAINT [DF_Coption_WalletAcct] DEFAULT ('') FOR [WalletAcct] ,
   CONSTRAINT [DF_Coption_PayoutProcessors] DEFAULT ('') FOR [PayoutProcessors] ,
   CONSTRAINT [DF_Coption_PaymentOptions] DEFAULT ('') FOR [PaymentOptions] ,
   CONSTRAINT [DF_Coption_MiscPay1] DEFAULT ('') FOR [MiscPay1] ,
   CONSTRAINT [DF_Coption_MiscPay2] DEFAULT ('') FOR [MiscPay2] ,
   CONSTRAINT [DF_Coption_MiscPay3] DEFAULT ('') FOR [MiscPay3] ,
   CONSTRAINT [DF_Coption_IPLimit] DEFAULT (0) FOR [IPLimit] ,
   CONSTRAINT [DF_Coption_InputOptions] DEFAULT ('') FOR [InputOptions] ,
   CONSTRAINT [DF_Coption_GAAcct] DEFAULT ('') FOR [GAAcct] ,
   CONSTRAINT [DF_Coption_Countries] DEFAULT ('') FOR [Countries] ,
   CONSTRAINT [DF_Coption_MenuColors] DEFAULT ('') FOR [MenuColors] ,
   CONSTRAINT [DF_Coption_Portal] DEFAULT ('') FOR [Portal] ,
   CONSTRAINT [DF_Coption_Shopping] DEFAULT ('') FOR [Shopping]
GO

ALTER TABLE [dbo].[Coption] WITH NOCHECK ADD
   CONSTRAINT [PK_Coption] PRIMARY KEY NONCLUSTERED
   ([CoptionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Coption_CompanyID]
   ON [dbo].[Coption]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO