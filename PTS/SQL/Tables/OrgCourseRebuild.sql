EXEC [dbo].pts_CheckTableRebuild 'OrgCourse'
 GO

ALTER TABLE [dbo].[OrgCourse] WITH NOCHECK ADD
   CONSTRAINT [DF_OrgCourse_OrgID] DEFAULT (0) FOR [OrgID] ,
   CONSTRAINT [DF_OrgCourse_CourseID] DEFAULT (0) FOR [CourseID] ,
   CONSTRAINT [DF_OrgCourse_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_OrgCourse_QuizLimit] DEFAULT (0) FOR [QuizLimit] ,
   CONSTRAINT [DF_OrgCourse_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[OrgCourse] WITH NOCHECK ADD
   CONSTRAINT [PK_OrgCourse] PRIMARY KEY NONCLUSTERED
   ([OrgCourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_OrgCourse_OrgCourse]
   ON [dbo].[OrgCourse]
   ([OrgID], [CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_OrgCourse_CourseID]
   ON [dbo].[OrgCourse]
   ([CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO