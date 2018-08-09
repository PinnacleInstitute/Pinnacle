EXEC [dbo].pts_CheckTableRebuild 'SalesZip'
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