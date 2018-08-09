EXEC [dbo].pts_CheckTableRebuild 'Homework'
 GO

ALTER TABLE [dbo].[Homework] WITH NOCHECK ADD
   CONSTRAINT [DF_Homework_LessonID] DEFAULT (0) FOR [LessonID] ,
   CONSTRAINT [DF_Homework_Name] DEFAULT ('') FOR [Name] ,
   CONSTRAINT [DF_Homework_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Homework_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Homework_Weight] DEFAULT (0) FOR [Weight] ,
   CONSTRAINT [DF_Homework_IsGrade] DEFAULT (0) FOR [IsGrade]
GO

ALTER TABLE [dbo].[Homework] WITH NOCHECK ADD
   CONSTRAINT [PK_Homework] PRIMARY KEY NONCLUSTERED
   ([HomeworkID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Homework_LessonID]
   ON [dbo].[Homework]
   ([LessonID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO