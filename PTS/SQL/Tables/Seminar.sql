EXEC [dbo].pts_CheckTable 'Seminar'
 GO

CREATE TABLE [dbo].[Seminar] (
   [SeminarID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [SeminarName] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Seminar] WITH NOCHECK ADD
   CONSTRAINT [DF_Seminar_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Seminar_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Seminar_SeminarName] DEFAULT ('') FOR [SeminarName] ,
   CONSTRAINT [DF_Seminar_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Seminar_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[Seminar] WITH NOCHECK ADD
   CONSTRAINT [PK_Seminar] PRIMARY KEY NONCLUSTERED
   ([SeminarID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Seminar_CompanyID]
   ON [dbo].[Seminar]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Seminar_MemberID]
   ON [dbo].[Seminar]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO