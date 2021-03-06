EXEC [dbo].pts_CheckTable 'Question'
 GO

CREATE TABLE [dbo].[Question] (
   [QuestionID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [QuestionTypeID] int NOT NULL ,
   [QuestionDate] datetime NOT NULL ,
   [Question] nvarchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Answer] nvarchar (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Reference] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [Status] int NOT NULL ,
   [Secure] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Question] WITH NOCHECK ADD
   CONSTRAINT [DF_Question_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Question_QuestionTypeID] DEFAULT (0) FOR [QuestionTypeID] ,
   CONSTRAINT [DF_Question_QuestionDate] DEFAULT (0) FOR [QuestionDate] ,
   CONSTRAINT [DF_Question_Question] DEFAULT ('') FOR [Question] ,
   CONSTRAINT [DF_Question_Answer] DEFAULT ('') FOR [Answer] ,
   CONSTRAINT [DF_Question_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Question_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Question_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Question_Secure] DEFAULT (0) FOR [Secure]
GO

ALTER TABLE [dbo].[Question] WITH NOCHECK ADD
   CONSTRAINT [PK_Question] PRIMARY KEY NONCLUSTERED
   ([QuestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Question_QuestionTypeID]
   ON [dbo].[Question]
   ([QuestionTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Question_CompanyID]
   ON [dbo].[Question]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO