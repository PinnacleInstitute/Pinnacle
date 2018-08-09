EXEC [dbo].pts_CheckTable 'AssessChoice'
 GO

CREATE TABLE [dbo].[AssessChoice] (
   [AssessChoiceID] int IDENTITY (1,1) NOT NULL ,
   [AssessQuestionID] int NOT NULL ,
   [Choice] nvarchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [Points] int NOT NULL ,
   [NextQuestion] int NOT NULL ,
   [Courses] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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