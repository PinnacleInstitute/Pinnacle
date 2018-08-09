EXEC [dbo].pts_CheckTableRebuild 'MemberContest'
 GO

ALTER TABLE [dbo].[MemberContest] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberContest_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberContest_ContestID] DEFAULT (0) FOR [ContestID]
GO

ALTER TABLE [dbo].[MemberContest] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberContest] PRIMARY KEY NONCLUSTERED
   ([MemberContestID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberContest_MemberID]
   ON [dbo].[MemberContest]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberContest_ContestID]
   ON [dbo].[MemberContest]
   ([ContestID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO