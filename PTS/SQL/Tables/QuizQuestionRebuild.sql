EXEC [dbo].pts_CheckTableRebuild 'QuizQuestion'
 GO

ALTER TABLE [dbo].[QuizQuestion] WITH NOCHECK ADD
   CONSTRAINT [DF_QuizQuestion_LessonID] DEFAULT (0) FOR [LessonID] ,
   CONSTRAINT [DF_QuizQuestion_QuizChoiceID] DEFAULT (0) FOR [QuizChoiceID] ,
   CONSTRAINT [DF_QuizQuestion_Question] DEFAULT ('') FOR [Question] ,
   CONSTRAINT [DF_QuizQuestion_Explain] DEFAULT ('') FOR [Explain] ,
   CONSTRAINT [DF_QuizQuestion_Points] DEFAULT (0) FOR [Points] ,
   CONSTRAINT [DF_QuizQuestion_IsRandom] DEFAULT (0) FOR [IsRandom] ,
   CONSTRAINT [DF_QuizQuestion_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_QuizQuestion_MediaType] DEFAULT (0) FOR [MediaType] ,
   CONSTRAINT [DF_QuizQuestion_MediaFile] DEFAULT ('') FOR [MediaFile]
GO

ALTER TABLE [dbo].[QuizQuestion] WITH NOCHECK ADD
   CONSTRAINT [PK_QuizQuestion] PRIMARY KEY NONCLUSTERED
   ([QuizQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_QuizQuestion_LessonID]
   ON [dbo].[QuizQuestion]
   ([LessonID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO