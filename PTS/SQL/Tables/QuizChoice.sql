EXEC [dbo].pts_CheckTable 'QuizChoice'
 GO

CREATE TABLE [dbo].[QuizChoice] (
   [QuizChoiceID] int IDENTITY (1,1) NOT NULL ,
   [QuizQuestionID] int NOT NULL ,
   [QuizChoiceText] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[QuizChoice] WITH NOCHECK ADD
   CONSTRAINT [DF_QuizChoice_QuizQuestionID] DEFAULT (0) FOR [QuizQuestionID] ,
   CONSTRAINT [DF_QuizChoice_QuizChoiceText] DEFAULT ('') FOR [QuizChoiceText] ,
   CONSTRAINT [DF_QuizChoice_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[QuizChoice] WITH NOCHECK ADD
   CONSTRAINT [PK_QuizChoice] PRIMARY KEY NONCLUSTERED
   ([QuizChoiceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_QuizChoice_QuizQuestionID]
   ON [dbo].[QuizChoice]
   ([QuizQuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO