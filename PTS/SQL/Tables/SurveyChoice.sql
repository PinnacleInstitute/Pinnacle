EXEC [dbo].pts_CheckTable 'SurveyChoice'
 GO

CREATE TABLE [dbo].[SurveyChoice] (
   [SurveyChoiceID] int IDENTITY (1,1) NOT NULL ,
   [SurveyQuestionID] int NOT NULL ,
   [Choice] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [Total] int NOT NULL 
   ) ON [PRIMARY]
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