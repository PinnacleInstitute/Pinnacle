EXEC [dbo].pts_CheckTable 'PageSection'
 GO

CREATE TABLE [dbo].[PageSection] (
   [PageSectionID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [PageSectionName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FileName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Path] nvarchar (128) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Language] nvarchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Width] int NOT NULL ,
   [Custom] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PageSection] WITH NOCHECK ADD
   CONSTRAINT [DF_PageSection_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_PageSection_PageSectionName] DEFAULT ('') FOR [PageSectionName] ,
   CONSTRAINT [DF_PageSection_FileName] DEFAULT ('') FOR [FileName] ,
   CONSTRAINT [DF_PageSection_Path] DEFAULT ('') FOR [Path] ,
   CONSTRAINT [DF_PageSection_Language] DEFAULT ('') FOR [Language] ,
   CONSTRAINT [DF_PageSection_Width] DEFAULT (0) FOR [Width] ,
   CONSTRAINT [DF_PageSection_Custom] DEFAULT (0) FOR [Custom]
GO

ALTER TABLE [dbo].[PageSection] WITH NOCHECK ADD
   CONSTRAINT [PK_PageSection] PRIMARY KEY NONCLUSTERED
   ([PageSectionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_PageSection_CompanyID]
   ON [dbo].[PageSection]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO