EXEC [dbo].pts_CheckTableRebuild 'MemberNews'
 GO

ALTER TABLE [dbo].[MemberNews] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberNews_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberNews_NewsLetterID] DEFAULT (0) FOR [NewsLetterID] ,
   CONSTRAINT [DF_MemberNews_EnrollDate] DEFAULT (0) FOR [EnrollDate]
GO

ALTER TABLE [dbo].[MemberNews] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberNews] PRIMARY KEY NONCLUSTERED
   ([MemberNewsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberNews_MemberID]
   ON [dbo].[MemberNews]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO