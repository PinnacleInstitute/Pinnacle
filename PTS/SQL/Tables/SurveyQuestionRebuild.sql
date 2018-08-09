EXEC [dbo].pts_CheckTableRebuild 'SurveyQuestion'
 GO

ALTER TABLE [dbo].[SurveyQuestion] WITH NOCHECK ADD
   CONSTRAINT [DF_SurveyQuestion_SurveyID] DEFAULT (0) FOR [SurveyID] ,
   CONSTRAINT [DF_SurveyQuestion_Question] DEFAULT ('') FOR [Question] ,
   CONSTRAINT [DF_SurveyQuestion_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_SurveyQuestion_IsText] DEFAULT (0) FOR [IsText] ,
   CONSTRAINT [DF_SurveyQuestion_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_SurveyQuestion_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[SurveyQuestion] WITH NOCHECK ADD
   CONSTRAINT [PK_SurveyQuestion] PRIMARY KEY NONCLUSTERED
   ([SurveyQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SurveyQuestion_SurveyID]
   ON [dbo].[SurveyQuestion]
   ([SurveyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO