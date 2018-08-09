EXEC [dbo].pts_CheckTableRebuild 'SurveyChoice'
 GO

ALTER TABLE [dbo].[SurveyChoice] WITH NOCHECK ADD
   CONSTRAINT [DF_SurveyChoice_SurveyQuestionID] DEFAULT (0) FOR [SurveyQuestionID] ,
   CONSTRAINT [DF_SurveyChoice_Choice] DEFAULT ('') FOR [Choice] ,
   CONSTRAINT [DF_SurveyChoice_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_SurveyChoice_Total] DEFAULT (0) FOR [Total]
GO

ALTER TABLE [dbo].[SurveyChoice] WITH NOCHECK ADD
   CONSTRAINT [PK_SurveyChoice] PRIMARY KEY NONCLUSTERED
   ([SurveyChoiceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SurveyChoice_SurveyQuestionID]
   ON [dbo].[SurveyChoice]
   ([SurveyQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO