EXEC [dbo].pts_CheckTable 'Lesson'
 GO

CREATE TABLE [dbo].[Lesson] (
   [LessonID] int IDENTITY (1,1) NOT NULL ,
   [CourseID] int NOT NULL ,
   [LessonName] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [LessonLength] int NOT NULL ,
   [Seq] int NOT NULL ,
   [MediaURL] varchar (250) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [MediaType] int NOT NULL ,
   [MediaLength] int NOT NULL ,
   [MediaWidth] int NOT NULL ,
   [MediaHeight] int NOT NULL ,
   [Content] int NOT NULL ,
   [Quiz] int NOT NULL ,
   [QuizLimit] int NOT NULL ,
   [QuizLength] int NOT NULL ,
   [PassingGrade] int NOT NULL ,
   [QuizWeight] int NOT NULL ,
   [IsPassQuiz] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Lesson] WITH NOCHECK ADD
   CONSTRAINT [DF_Lesson_CourseID] DEFAULT (0) FOR [CourseID] ,
   CONSTRAINT [DF_Lesson_LessonName] DEFAULT ('') FOR [LessonName] ,
   CONSTRAINT [DF_Lesson_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Lesson_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Lesson_LessonLength] DEFAULT (0) FOR [LessonLength] ,
   CONSTRAINT [DF_Lesson_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Lesson_MediaURL] DEFAULT ('') FOR [MediaURL] ,
   CONSTRAINT [DF_Lesson_MediaType] DEFAULT (0) FOR [MediaType] ,
   CONSTRAINT [DF_Lesson_MediaLength] DEFAULT (0) FOR [MediaLength] ,
   CONSTRAINT [DF_Lesson_MediaWidth] DEFAULT (0) FOR [MediaWidth] ,
   CONSTRAINT [DF_Lesson_MediaHeight] DEFAULT (0) FOR [MediaHeight] ,
   CONSTRAINT [DF_Lesson_Content] DEFAULT (0) FOR [Content] ,
   CONSTRAINT [DF_Lesson_Quiz] DEFAULT (0) FOR [Quiz] ,
   CONSTRAINT [DF_Lesson_QuizLimit] DEFAULT (0) FOR [QuizLimit] ,
   CONSTRAINT [DF_Lesson_QuizLength] DEFAULT (0) FOR [QuizLength] ,
   CONSTRAINT [DF_Lesson_PassingGrade] DEFAULT (0) FOR [PassingGrade] ,
   CONSTRAINT [DF_Lesson_QuizWeight] DEFAULT (0) FOR [QuizWeight] ,
   CONSTRAINT [DF_Lesson_IsPassQuiz] DEFAULT (0) FOR [IsPassQuiz]
GO

ALTER TABLE [dbo].[Lesson] WITH NOCHECK ADD
   CONSTRAINT [PK_Lesson] PRIMARY KEY NONCLUSTERED
   ([LessonID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Lesson_CourseID]
   ON [dbo].[Lesson]
   ([CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO