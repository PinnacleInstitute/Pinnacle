EXEC [dbo].pts_CheckTable 'SalesZip'
 GO

CREATE TABLE [dbo].[SalesZip] (
   [SalesZipID] int IDENTITY (1,1) NOT NULL ,
   [SalesAreaID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [ZipCode] varchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ZipName] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [StatusDate] datetime NOT NULL ,
   [Population] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesZip] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesZip_SalesAreaID] DEFAULT (0) FOR [SalesAreaID] ,
   CONSTRAINT [DF_SalesZip_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_SalesZip_ZipCode] DEFAULT ('') FOR [ZipCode] ,
   CONSTRAINT [DF_SalesZip_ZipName] DEFAULT ('') FOR [ZipName] ,
   CONSTRAINT [DF_SalesZip_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesZip_StatusDate] DEFAULT (0) FOR [StatusDate] ,
   CONSTRAINT [DF_SalesZip_Population] DEFAULT (0) FOR [Population]
GO

ALTER TABLE [dbo].[SalesZip] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesZip] PRIMARY KEY NONCLUSTERED
   ([SalesZipID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesZip_SalesAreaID]
   ON [dbo].[SalesZip]
   ([SalesAreaID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesZip_ZipCode]
   ON [dbo].[SalesZip]
   ([CountryID], [ZipCode])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO