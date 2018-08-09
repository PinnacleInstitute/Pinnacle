EXEC [dbo].pts_CheckTableRebuild 'QuestionType'
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