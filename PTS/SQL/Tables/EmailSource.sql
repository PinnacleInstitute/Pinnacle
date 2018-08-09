EXEC [dbo].pts_CheckTable 'EmailSource'
 GO

CREATE TABLE [dbo].[EmailSource] (
   [EmailSourceID] int IDENTITY (1,1) NOT NULL ,
   [EmailSourceName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EmailSourceFrom] varchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EmailSourceFields] varchar (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[EmailSource] WITH NOCHECK ADD
   CONSTRAINT [DF_EmailSource_EmailSourceName] DEFAULT ('') FOR [EmailSourceName] ,
   CONSTRAINT [DF_EmailSource_EmailSourceFrom] DEFAULT ('') FOR [EmailSourceFrom] ,
   CONSTRAINT [DF_EmailSource_EmailSourceFields] DEFAULT ('') FOR [EmailSourceFields]
GO

ALTER TABLE [dbo].[EmailSource] WITH NOCHECK ADD
   CONSTRAINT [PK_EmailSource] PRIMARY KEY NONCLUSTERED
   ([EmailSourceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UI_EmailSource_EmailSourceName]
   ON [dbo].[EmailSource]
   ([EmailSourceName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO