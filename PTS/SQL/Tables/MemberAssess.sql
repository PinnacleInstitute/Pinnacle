EXEC [dbo].pts_CheckTable 'MemberAssess'
 GO

CREATE TABLE [dbo].[MemberAssess] (
   [MemberAssessID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [AssessmentID] int NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [CompleteDate] datetime NOT NULL ,
   [Status] int NOT NULL ,
   [ExternalID] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Result] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Score] decimal (10, 6) NOT NULL ,
   [TrainerScore] int NOT NULL ,
   [CommStatus] int NOT NULL ,
   [IsPrivate] bit NOT NULL ,
   [IsRemoved] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MemberAssess] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberAssess_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberAssess_AssessmentID] DEFAULT (0) FOR [AssessmentID] ,
   CONSTRAINT [DF_MemberAssess_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_MemberAssess_CompleteDate] DEFAULT (0) FOR [CompleteDate] ,
   CONSTRAINT [DF_MemberAssess_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_MemberAssess_ExternalID] DEFAULT ('') FOR [ExternalID] ,
   CONSTRAINT [DF_MemberAssess_Result] DEFAULT ('') FOR [Result] ,
   CONSTRAINT [DF_MemberAssess_Score] DEFAULT (0) FOR [Score] ,
   CONSTRAINT [DF_MemberAssess_TrainerScore] DEFAULT (0) FOR [TrainerScore] ,
   CONSTRAINT [DF_MemberAssess_CommStatus] DEFAULT (0) FOR [CommStatus] ,
   CONSTRAINT [DF_MemberAssess_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_MemberAssess_IsRemoved] DEFAULT (0) FOR [IsRemoved]
GO

ALTER TABLE [dbo].[MemberAssess] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberAssess] PRIMARY KEY NONCLUSTERED
   ([MemberAssessID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberAssess_MemberAssess]
   ON [dbo].[MemberAssess]
   ([MemberID], [AssessmentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberAssess_TrainerScore]
   ON [dbo].[MemberAssess]
   ([TrainerScore], [CompleteDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO