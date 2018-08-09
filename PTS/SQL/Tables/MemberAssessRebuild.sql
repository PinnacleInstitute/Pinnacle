EXEC [dbo].pts_CheckTableRebuild 'MemberAssess'
 GO

ALTER TABLE [dbo].[MemberAssess] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberAssess_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberAssess_AssessmentID] DEFAULT (0) FOR [AssessmentID] ,
   CONSTRAINT [DF_MemberAssess_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_MemberAssess_CompleteDate] DEFAULT (0) FOR [CompleteDate] ,
   CONSTRAINT [DF_MemberAssess_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_MemberAssess_ExternalID] DEFAULT ('') FOR [ExternalID] ,
   CONSTRAINT [DF_MemberAssess_Result] DEFAULT ('') FOR [Result] ,
   CONSTRAINT [DF_MemberAssess_Score] DEFAULT (0) FOR [Score] ,
   CONSTRAINT [DF_MemberAssess_TrainerScore] DEFAULT (0) FOR [TrainerScore] ,
   CONSTRAINT [DF_MemberAssess_CommStatus] DEFAULT (0) FOR [CommStatus] ,
   CONSTRAINT [DF_MemberAssess_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_MemberAssess_IsRemoved] DEFAULT (0) FOR [IsRemoved]
GO

ALTER TABLE [dbo].[MemberAssess] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberAssess] PRIMARY KEY NONCLUSTERED
   ([MemberAssessID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberAssess_MemberAssess]
   ON [dbo].[MemberAssess]
   ([MemberID], [AssessmentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberAssess_TrainerScore]
   ON [dbo].[MemberAssess]
   ([TrainerScore], [CompleteDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO