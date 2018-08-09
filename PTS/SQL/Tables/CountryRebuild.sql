EXEC [dbo].pts_CheckTableRebuild 'Country'
 GO

ALTER TABLE [dbo].[Country] WITH NOCHECK ADD
   CONSTRAINT [DF_Country_CountryName] DEFAULT ('') FOR [CountryName] ,
   CONSTRAINT [DF_Country_Code] DEFAULT ('') FOR [Code] ,
   CONSTRAINT [DF_Country_Curr] DEFAULT (0) FOR [Curr]
GO

ALTER TABLE [dbo].[Country] WITH NOCHECK ADD
   CONSTRAINT [PK_Country] PRIMARY KEY NONCLUSTERED
   ([CountryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO