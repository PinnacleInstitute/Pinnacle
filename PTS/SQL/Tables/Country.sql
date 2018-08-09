EXEC [dbo].pts_CheckTable 'Country'
 GO

CREATE TABLE [dbo].[Country] (
   [CountryID] int IDENTITY (1,1) NOT NULL ,
   [CountryName] nvarchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Code] varchar (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Curr] int NOT NULL 
   ) ON [PRIMARY]
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