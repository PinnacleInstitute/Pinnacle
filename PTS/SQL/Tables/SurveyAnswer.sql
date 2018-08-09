EXEC [dbo].pts_CheckTable 'SurveyAnswer'
 GO

CREATE TABLE [dbo].[SurveyAnswer] (
   [SurveyAnswerID] int IDENTITY (1,1) NOT NULL ,
   [SurveyQuestionID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [SurveyChoiceID] int NOT NULL ,
   [Answer] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [AnswerDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SurveyAnswer] WITH NOCHECK ADD
   CONSTRAINT [DF_SurveyAnswer_SurveyQuestionID] DEFAULT (0) FOR [SurveyQuestionID] ,
   CONSTRAINT [DF_SurveyAnswer_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_SurveyAnswer_SurveyChoiceID] DEFAULT (0) FOR [SurveyChoiceID] ,
   CONSTRAINT [DF_SurveyAnswer_Answer] DEFAULT ('') FOR [Answer] ,
   CONSTRAINT [DF_SurveyAnswer_AnswerDate] DEFAULT (0) FOR [AnswerDate]
GO

ALTER TABLE [dbo].[SurveyAnswer] WITH NOCHECK ADD
   CONSTRAINT [PK_SurveyAnswer] PRIMARY KEY NONCLUSTERED
   ([SurveyAnswerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SurveyAnswer_SurveyQuestionID]
   ON [dbo].[SurveyAnswer]
   ([SurveyQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SurveyAnswer_MemberID]
   ON [dbo].[SurveyAnswer]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO