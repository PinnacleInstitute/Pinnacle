EXEC [dbo].pts_CheckTable 'AssessAnswer'
 GO

CREATE TABLE [dbo].[AssessAnswer] (
   [AssessAnswerID] int IDENTITY (1,1) NOT NULL ,
   [MemberAssessID] int NOT NULL ,
   [AssessQuestionID] int NOT NULL ,
   [AssessChoiceID] int NOT NULL ,
   [Answer] int NOT NULL ,
   [AnswerDate] datetime NOT NULL ,
   [AnswerText] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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