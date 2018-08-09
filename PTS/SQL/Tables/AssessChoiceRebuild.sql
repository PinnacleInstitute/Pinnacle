EXEC [dbo].pts_CheckTableRebuild 'AssessChoice'
 GO

ALTER TABLE [dbo].[AssessChoice] WITH NOCHECK ADD
   CONSTRAINT [DF_AssessChoice_AssessQuestionID] DEFAULT (0) FOR [AssessQuestionID] ,
   CONSTRAINT [DF_AssessChoice_Choice] DEFAULT ('') FOR [Choice] ,
   CONSTRAINT [DF_AssessChoice_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_AssessChoice_Points] DEFAULT (0) FOR [Points] ,
   CONSTRAINT [DF_AssessChoice_NextQuestion] DEFAULT (0) FOR [NextQuestion] ,
   CONSTRAINT [DF_AssessChoice_Courses] DEFAULT ('') FOR [Courses]
GO

ALTER TABLE [dbo].[AssessChoice] WITH NOCHECK ADD
   CONSTRAINT [PK_AssessChoice] PRIMARY KEY NONCLUSTERED
   ([AssessChoiceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AssessChoice_AssessQuestionID]
   ON [dbo].[AssessChoice]
   ([AssessQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO