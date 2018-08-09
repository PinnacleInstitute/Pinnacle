EXEC [dbo].pts_CheckTable 'QuestionType'
 GO

CREATE TABLE [dbo].[QuestionType] (
   [QuestionTypeID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [QuestionTypeName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [UserType] int NOT NULL ,
   [Secure] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[QuestionType] WITH NOCHECK ADD
   CONSTRAINT [DF_QuestionType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_QuestionType_QuestionTypeName] DEFAULT ('') FOR [QuestionTypeName] ,
   CONSTRAINT [DF_QuestionType_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_QuestionType_UserType] DEFAULT (0) FOR [UserType] ,
   CONSTRAINT [DF_QuestionType_Secure] DEFAULT (0) FOR [Secure]
GO

ALTER TABLE [dbo].[QuestionType] WITH NOCHECK ADD
   CONSTRAINT [PK_QuestionType] PRIMARY KEY NONCLUSTERED
   ([QuestionTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_QuestionType_QuestionTypeName]
   ON [dbo].[QuestionType]
   ([QuestionTypeName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_QuestionType_CompanyID]
   ON [dbo].[QuestionType]
   ([CompanyID], [UserType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO