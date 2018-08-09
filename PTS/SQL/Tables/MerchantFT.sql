EXEC [dbo].pts_CheckTable 'MerchantFT'
 GO

CREATE TABLE [dbo].[MerchantFT] (
   [MerchantID] int NOT NULL ,
   [FT] nvarchar (2250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MerchantFT] WITH NOCHECK ADD
   CONSTRAINT [DF_Merchant_FT] DEFAULT ('') FOR [FT] 
GO

ALTER TABLE [dbo].[MerchantFT] WITH NOCHECK ADD
   CONSTRAINT [PK_MerchantFT] PRIMARY KEY NONCLUSTERED
   ([MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO
