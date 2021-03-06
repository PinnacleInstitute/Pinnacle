EXEC [dbo].pts_CheckTableRebuild 'BarterAd'
 GO

ALTER TABLE [dbo].[BarterAd] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterAd_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_BarterAd_BarterArea1ID] DEFAULT (0) FOR [BarterArea1ID] ,
   CONSTRAINT [DF_BarterAd_BarterArea2ID] DEFAULT (0) FOR [BarterArea2ID] ,
   CONSTRAINT [DF_BarterAd_BarterCategoryID] DEFAULT (0) FOR [BarterCategoryID] ,
   CONSTRAINT [DF_BarterAd_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_BarterAd_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterAd_PostDate] DEFAULT (0) FOR [PostDate] ,
   CONSTRAINT [DF_BarterAd_UpdateDate] DEFAULT (0) FOR [UpdateDate] ,
   CONSTRAINT [DF_BarterAd_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_BarterAd_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_BarterAd_Location] DEFAULT ('') FOR [Location] ,
   CONSTRAINT [DF_BarterAd_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_BarterAd_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_BarterAd_Language] DEFAULT ('') FOR [Language] ,
   CONSTRAINT [DF_BarterAd_ContactName] DEFAULT ('') FOR [ContactName] ,
   CONSTRAINT [DF_BarterAd_ContactEmail] DEFAULT ('') FOR [ContactEmail] ,
   CONSTRAINT [DF_BarterAd_ContactPhone] DEFAULT ('') FOR [ContactPhone] ,
   CONSTRAINT [DF_BarterAd_IsEmail] DEFAULT (0) FOR [IsEmail] ,
   CONSTRAINT [DF_BarterAd_IsPhone] DEFAULT (0) FOR [IsPhone] ,
   CONSTRAINT [DF_BarterAd_IsText] DEFAULT (0) FOR [IsText] ,
   CONSTRAINT [DF_BarterAd_IsMore] DEFAULT (0) FOR [IsMore] ,
   CONSTRAINT [DF_BarterAd_IsMap] DEFAULT (0) FOR [IsMap] ,
   CONSTRAINT [DF_BarterAd_IsContact] DEFAULT (0) FOR [IsContact] ,
   CONSTRAINT [DF_BarterAd_IsDealer] DEFAULT (0) FOR [IsDealer] ,
   CONSTRAINT [DF_BarterAd_MapStreet1] DEFAULT ('') FOR [MapStreet1] ,
   CONSTRAINT [DF_BarterAd_MapStreet2] DEFAULT ('') FOR [MapStreet2] ,
   CONSTRAINT [DF_BarterAd_MapCity] DEFAULT ('') FOR [MapCity] ,
   CONSTRAINT [DF_BarterAd_MapZip] DEFAULT ('') FOR [MapZip] ,
   CONSTRAINT [DF_BarterAd_Options] DEFAULT ('') FOR [Options] ,
   CONSTRAINT [DF_BarterAd_Payments] DEFAULT ('') FOR [Payments] ,
   CONSTRAINT [DF_BarterAd_Condition] DEFAULT (0) FOR [Condition] ,
   CONSTRAINT [DF_BarterAd_Images] DEFAULT (0) FOR [Images] ,
   CONSTRAINT [DF_BarterAd_GeoCode] DEFAULT ('') FOR [GeoCode] ,
   CONSTRAINT [DF_BarterAd_T1] DEFAULT ('') FOR [T1] ,
   CONSTRAINT [DF_BarterAd_T2] DEFAULT ('') FOR [T2] ,
   CONSTRAINT [DF_BarterAd_T3] DEFAULT ('') FOR [T3] ,
   CONSTRAINT [DF_BarterAd_T4] DEFAULT ('') FOR [T4] ,
   CONSTRAINT [DF_BarterAd_T5] DEFAULT ('') FOR [T5] ,
   CONSTRAINT [DF_BarterAd_N1] DEFAULT (0) FOR [N1] ,
   CONSTRAINT [DF_BarterAd_N2] DEFAULT (0) FOR [N2] ,
   CONSTRAINT [DF_BarterAd_N3] DEFAULT (0) FOR [N3] ,
   CONSTRAINT [DF_BarterAd_N4] DEFAULT (0) FOR [N4] ,
   CONSTRAINT [DF_BarterAd_N5] DEFAULT (0) FOR [N5] ,
   CONSTRAINT [DF_BarterAd_L1] DEFAULT (0) FOR [L1] ,
   CONSTRAINT [DF_BarterAd_L2] DEFAULT (0) FOR [L2] ,
   CONSTRAINT [DF_BarterAd_L3] DEFAULT (0) FOR [L3] ,
   CONSTRAINT [DF_BarterAd_L4] DEFAULT (0) FOR [L4] ,
   CONSTRAINT [DF_BarterAd_L5] DEFAULT (0) FOR [L5] ,
   CONSTRAINT [DF_BarterAd_L6] DEFAULT (0) FOR [L6] ,
   CONSTRAINT [DF_BarterAd_L7] DEFAULT (0) FOR [L7] ,
   CONSTRAINT [DF_BarterAd_L8] DEFAULT (0) FOR [L8] ,
   CONSTRAINT [DF_BarterAd_L9] DEFAULT (0) FOR [L9] ,
   CONSTRAINT [DF_BarterAd_L10] DEFAULT (0) FOR [L10] ,
   CONSTRAINT [DF_BarterAd_Y1] DEFAULT (0) FOR [Y1] ,
   CONSTRAINT [DF_BarterAd_Y2] DEFAULT (0) FOR [Y2] ,
   CONSTRAINT [DF_BarterAd_Y3] DEFAULT (0) FOR [Y3] ,
   CONSTRAINT [DF_BarterAd_Y4] DEFAULT (0) FOR [Y4] ,
   CONSTRAINT [DF_BarterAd_Y5] DEFAULT (0) FOR [Y5] ,
   CONSTRAINT [DF_BarterAd_Y6] DEFAULT (0) FOR [Y6] ,
   CONSTRAINT [DF_BarterAd_Y7] DEFAULT (0) FOR [Y7] ,
   CONSTRAINT [DF_BarterAd_Y8] DEFAULT (0) FOR [Y8] ,
   CONSTRAINT [DF_BarterAd_Y9] DEFAULT (0) FOR [Y9] ,
   CONSTRAINT [DF_BarterAd_Y10] DEFAULT (0) FOR [Y10] ,
   CONSTRAINT [DF_BarterAd_D1] DEFAULT (0) FOR [D1] ,
   CONSTRAINT [DF_BarterAd_D2] DEFAULT (0) FOR [D2] ,
   CONSTRAINT [DF_BarterAd_D3] DEFAULT (0) FOR [D3] ,
   CONSTRAINT [DF_BarterAd_D4] DEFAULT (0) FOR [D4] ,
   CONSTRAINT [DF_BarterAd_D5] DEFAULT (0) FOR [D5]
GO

ALTER TABLE [dbo].[BarterAd] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterAd] PRIMARY KEY NONCLUSTERED
   ([BarterAdID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterAd_BarterArea1ID]
   ON [dbo].[BarterAd]
   ([BarterArea1ID], [BarterCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO