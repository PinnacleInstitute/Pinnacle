EXEC [dbo].pts_CheckTable 'LabLang'
 GO

CREATE TABLE [dbo].[LabLang] (
   [LabLangID] int IDENTITY (1,1) NOT NULL ,
   [LanguageName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [LanguageCode] nvarchar (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LabLang] WITH NOCHECK ADD
   CONSTRAINT [DF_LabLang_LanguageName] DEFAULT ('') FOR [LanguageName] ,
   CONSTRAINT [DF_LabLang_LanguageCode] DEFAULT ('') FOR [LanguageCode],
   CONSTRAINT [DF_LabLang_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_LabLang_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_LabLang_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_LabLang_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[LabLang] WITH NOCHECK ADD
   CONSTRAINT [PK_LabLang] PRIMARY KEY NONCLUSTERED
   ([LabLangID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO