EXEC [dbo].pts_CheckTableRebuild 'MemberTitle'
 GO

ALTER TABLE [dbo].[MemberTitle] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberTitle_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberTitle_TitleDate] DEFAULT (0) FOR [TitleDate] ,
   CONSTRAINT [DF_MemberTitle_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_MemberTitle_IsEarned] DEFAULT (0) FOR [IsEarned]
GO

ALTER TABLE [dbo].[MemberTitle] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberTitle] PRIMARY KEY NONCLUSTERED
   ([MemberTitleID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberTitle_MemberID]
   ON [dbo].[MemberTitle]
   ([MemberID], [TitleDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO