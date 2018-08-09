EXEC [dbo].pts_CheckTableRebuild 'QuizAnswer'
 GO

ALTER TABLE [dbo].[QuizAnswer] WITH NOCHECK ADD
   CONSTRAINT [DF_QuizAnswer_SessionLessonID] DEFAULT (0) FOR [SessionLessonID] ,
   CONSTRAINT [DF_QuizAnswer_QuizQuestionID] DEFAULT (0) FOR [QuizQuestionID] ,
   CONSTRAINT [DF_QuizAnswer_QuizChoiceID] DEFAULT (0) FOR [QuizChoiceID] ,
   CONSTRAINT [DF_QuizAnswer_IsCorrect] DEFAULT (0) FOR [IsCorrect] ,
   CONSTRAINT [DF_QuizAnswer_CreateDate] DEFAULT (0) FOR [CreateDate]
GO

ALTER TABLE [dbo].[QuizAnswer] WITH NOCHECK ADD
   CONSTRAINT [PK_QuizAnswer] PRIMARY KEY NONCLUSTERED
   ([QuizAnswerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_QuizAnswer_SessionQuestion]
   ON [dbo].[QuizAnswer]
   ([SessionLessonID], [QuizQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO