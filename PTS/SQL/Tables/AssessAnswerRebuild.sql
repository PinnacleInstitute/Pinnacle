EXEC [dbo].pts_CheckTableRebuild 'AssessAnswer'
 GO

ALTER TABLE [dbo].[AssessAnswer] WITH NOCHECK ADD
   CONSTRAINT [DF_AssessAnswer_MemberAssessID] DEFAULT (0) FOR [MemberAssessID] ,
   CONSTRAINT [DF_AssessAnswer_AssessQuestionID] DEFAULT (0) FOR [AssessQuestionID] ,
   CONSTRAINT [DF_AssessAnswer_AssessChoiceID] DEFAULT (0) FOR [AssessChoiceID] ,
   CONSTRAINT [DF_AssessAnswer_Answer] DEFAULT (0) FOR [Answer] ,
   CONSTRAINT [DF_AssessAnswer_AnswerDate] DEFAULT (0) FOR [AnswerDate] ,
   CONSTRAINT [DF_AssessAnswer_AnswerText] DEFAULT ('') FOR [AnswerText]
GO

ALTER TABLE [dbo].[AssessAnswer] WITH NOCHECK ADD
   CONSTRAINT [PK_AssessAnswer] PRIMARY KEY NONCLUSTERED
   ([AssessAnswerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AssessAnswer_MemberAssessID]
   ON [dbo].[AssessAnswer]
   ([MemberAssessID], [AssessQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO