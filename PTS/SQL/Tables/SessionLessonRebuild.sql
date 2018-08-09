EXEC [dbo].pts_CheckTableRebuild 'SessionLesson'
 GO

ALTER TABLE [dbo].[SessionLesson] WITH NOCHECK ADD
   CONSTRAINT [DF_SessionLesson_SessionID] DEFAULT (0) FOR [SessionID] ,
   CONSTRAINT [DF_SessionLesson_LessonID] DEFAULT (0) FOR [LessonID] ,
   CONSTRAINT [DF_SessionLesson_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SessionLesson_QuizScore] DEFAULT (0) FOR [QuizScore] ,
   CONSTRAINT [DF_SessionLesson_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_SessionLesson_CompleteDate] DEFAULT (0) FOR [CompleteDate] ,
   CONSTRAINT [DF_SessionLesson_Time] DEFAULT (0) FOR [Time] ,
   CONSTRAINT [DF_SessionLesson_Times] DEFAULT (0) FOR [Times] ,
   CONSTRAINT [DF_SessionLesson_Questions] DEFAULT ('') FOR [Questions] ,
   CONSTRAINT [DF_SessionLesson_Location] DEFAULT ('') FOR [Location]
GO

ALTER TABLE [dbo].[SessionLesson] WITH NOCHECK ADD
   CONSTRAINT [PK_SessionLesson] PRIMARY KEY NONCLUSTERED
   ([SessionLessonID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SessionLesson_SessionLesson]
   ON [dbo].[SessionLesson]
   ([SessionID], [LessonID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO