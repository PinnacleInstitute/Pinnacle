EXEC [dbo].pts_CheckTable 'Course'
 GO

CREATE TABLE [dbo].[Course] (
   [CourseID] int IDENTITY (1,1) NOT NULL ,
   [CourseCategoryID] int NOT NULL ,
   [TrainerID] int NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ExamID] int NOT NULL ,
   [CourseName] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [CourseType] int NOT NULL ,
   [CourseLevel] int NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Language] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CourseLength] int NOT NULL ,
   [CourseDate] datetime NOT NULL ,
   [IsPaid] bit NOT NULL ,
   [Price] money NOT NULL ,
   [Grp] int NOT NULL ,
   [Seq] int NOT NULL ,
   [PassingGrade] int NOT NULL ,
   [Rating] int NOT NULL ,
   [RatingCnt] int NOT NULL ,
   [Classes] int NOT NULL ,
   [Video] bit NOT NULL ,
   [Audio] bit NOT NULL ,
   [Quiz] bit NOT NULL ,
   [Reference] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [ScoreFactor] decimal (10, 6) NOT NULL ,
   [NoCertificate] bit NOT NULL ,
   [NoEvaluation] bit NOT NULL ,
   [IsCustomCertificate] bit NOT NULL ,
   [Credit] money NOT NULL ,
   [ExamWeight] int NOT NULL ,
   [Pre] varchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Course] WITH NOCHECK ADD
   CONSTRAINT [DF_Course_CourseCategoryID] DEFAULT (0) FOR [CourseCategoryID] ,
   CONSTRAINT [DF_Course_TrainerID] DEFAULT (0) FOR [TrainerID] ,
   CONSTRAINT [DF_Course_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Course_ExamID] DEFAULT (0) FOR [ExamID] ,
   CONSTRAINT [DF_Course_CourseName] DEFAULT ('') FOR [CourseName] ,
   CONSTRAINT [DF_Course_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Course_CourseType] DEFAULT (0) FOR [CourseType] ,
   CONSTRAINT [DF_Course_CourseLevel] DEFAULT (0) FOR [CourseLevel] ,
   CONSTRAINT [DF_Course_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Course_Language] DEFAULT ('') FOR [Language] ,
   CONSTRAINT [DF_Course_CourseLength] DEFAULT (0) FOR [CourseLength] ,
   CONSTRAINT [DF_Course_CourseDate] DEFAULT (0) FOR [CourseDate] ,
   CONSTRAINT [DF_Course_IsPaid] DEFAULT (0) FOR [IsPaid] ,
   CONSTRAINT [DF_Course_Price] DEFAULT (0) FOR [Price] ,
   CONSTRAINT [DF_Course_Grp] DEFAULT (0) FOR [Grp] ,
   CONSTRAINT [DF_Course_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Course_PassingGrade] DEFAULT (0) FOR [PassingGrade] ,
   CONSTRAINT [DF_Course_Rating] DEFAULT (0) FOR [Rating] ,
   CONSTRAINT [DF_Course_RatingCnt] DEFAULT (0) FOR [RatingCnt] ,
   CONSTRAINT [DF_Course_Classes] DEFAULT (0) FOR [Classes] ,
   CONSTRAINT [DF_Course_Video] DEFAULT (0) FOR [Video] ,
   CONSTRAINT [DF_Course_Audio] DEFAULT (0) FOR [Audio] ,
   CONSTRAINT [DF_Course_Quiz] DEFAULT (0) FOR [Quiz] ,
   CONSTRAINT [DF_Course_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Course_ScoreFactor] DEFAULT (0) FOR [ScoreFactor] ,
   CONSTRAINT [DF_Course_NoCertificate] DEFAULT (0) FOR [NoCertificate] ,
   CONSTRAINT [DF_Course_NoEvaluation] DEFAULT (0) FOR [NoEvaluation] ,
   CONSTRAINT [DF_Course_IsCustomCertificate] DEFAULT (0) FOR [IsCustomCertificate] ,
   CONSTRAINT [DF_Course_Credit] DEFAULT (0) FOR [Credit] ,
   CONSTRAINT [DF_Course_ExamWeight] DEFAULT (0) FOR [ExamWeight] ,
   CONSTRAINT [DF_Course_Pre] DEFAULT ('') FOR [Pre]
GO

ALTER TABLE [dbo].[Course] WITH NOCHECK ADD
   CONSTRAINT [PK_Course] PRIMARY KEY NONCLUSTERED
   ([CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Course_TrainerID]
   ON [dbo].[Course]
   ([TrainerID], [CourseCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Course_CourseCategoryID]
   ON [dbo].[Course]
   ([CourseCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Course_Grp]
   ON [dbo].[Course]
   ([Grp], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Course_CompanyID]
   ON [dbo].[Course]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Course_Status]
   ON [dbo].[Course]
   ([Status], [CompanyID], [CourseDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO