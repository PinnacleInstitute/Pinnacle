EXEC [dbo].pts_CheckTable 'AssessQuestion'
 GO

CREATE TABLE [dbo].[AssessQuestion] (
   [AssessQuestionID] int IDENTITY (1,1) NOT NULL ,
   [AssessmentID] int NOT NULL ,
   [QuestionCode] int NOT NULL ,
   [Question] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Grp] int NOT NULL ,
   [Seq] int NOT NULL ,
   [QuestionType] int NOT NULL ,
   [RankMin] int NOT NULL ,
   [RankMax] int NOT NULL ,
   [ResultType] int NOT NULL ,
   [Answer] int NOT NULL ,
   [Points] int NOT NULL ,
   [NextType] int NOT NULL ,
   [NextQuestion] int NOT NULL ,
   [Formula] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CustomCode] int NOT NULL ,
   [MultiSelect] bit NOT NULL ,
   [MediaType] int NOT NULL ,
   [MediaFile] varchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Courses] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Discrimination] decimal (10, 8) NOT NULL ,
   [Difficulty] decimal (10, 8) NOT NULL ,
   [Guessing] decimal (10, 8) NOT NULL ,
   [UseCount] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AssessQuestion] WITH NOCHECK ADD
   CONSTRAINT [DF_AssessQuestion_AssessmentID] DEFAULT (0) FOR [AssessmentID] ,
   CONSTRAINT [DF_AssessQuestion_QuestionCode] DEFAULT (0) FOR [QuestionCode] ,
   CONSTRAINT [DF_AssessQuestion_Question] DEFAULT ('') FOR [Question] ,
   CONSTRAINT [DF_AssessQuestion_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_AssessQuestion_Grp] DEFAULT (0) FOR [Grp] ,
   CONSTRAINT [DF_AssessQuestion_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_AssessQuestion_QuestionType] DEFAULT (0) FOR [QuestionType] ,
   CONSTRAINT [DF_AssessQuestion_RankMin] DEFAULT (0) FOR [RankMin] ,
   CONSTRAINT [DF_AssessQuestion_RankMax] DEFAULT (0) FOR [RankMax] ,
   CONSTRAINT [DF_AssessQuestion_ResultType] DEFAULT (0) FOR [ResultType] ,
   CONSTRAINT [DF_AssessQuestion_Answer] DEFAULT (0) FOR [Answer] ,
   CONSTRAINT [DF_AssessQuestion_Points] DEFAULT (0) FOR [Points] ,
   CONSTRAINT [DF_AssessQuestion_NextType] DEFAULT (0) FOR [NextType] ,
   CONSTRAINT [DF_AssessQuestion_NextQuestion] DEFAULT (0) FOR [NextQuestion] ,
   CONSTRAINT [DF_AssessQuestion_Formula] DEFAULT ('') FOR [Formula] ,
   CONSTRAINT [DF_AssessQuestion_CustomCode] DEFAULT (0) FOR [CustomCode] ,
   CONSTRAINT [DF_AssessQuestion_MultiSelect] DEFAULT (0) FOR [MultiSelect] ,
   CONSTRAINT [DF_AssessQuestion_MediaType] DEFAULT (0) FOR [MediaType] ,
   CONSTRAINT [DF_AssessQuestion_MediaFile] DEFAULT ('') FOR [MediaFile] ,
   CONSTRAINT [DF_AssessQuestion_Courses] DEFAULT ('') FOR [Courses] ,
   CONSTRAINT [DF_AssessQuestion_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_AssessQuestion_Discrimination] DEFAULT (0) FOR [Discrimination] ,
   CONSTRAINT [DF_AssessQuestion_Difficulty] DEFAULT (0) FOR [Difficulty] ,
   CONSTRAINT [DF_AssessQuestion_Guessing] DEFAULT (0) FOR [Guessing] ,
   CONSTRAINT [DF_AssessQuestion_UseCount] DEFAULT (0) FOR [UseCount]
GO

ALTER TABLE [dbo].[AssessQuestion] WITH NOCHECK ADD
   CONSTRAINT [PK_AssessQuestion] PRIMARY KEY NONCLUSTERED
   ([AssessQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AssessQuestion_AssessmentID]
   ON [dbo].[AssessQuestion]
   ([AssessmentID], [QuestionCode])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AssessQuestion_Grp]
   ON [dbo].[AssessQuestion]
   ([AssessmentID], [Grp], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO