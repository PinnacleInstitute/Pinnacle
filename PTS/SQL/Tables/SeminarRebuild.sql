EXEC [dbo].pts_CheckTableRebuild 'Seminar'
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