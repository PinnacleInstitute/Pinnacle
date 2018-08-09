EXEC [dbo].pts_CheckTableRebuild 'PageSection'
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