EXEC [dbo].pts_CheckTable 'CourseCategory'
 GO

CREATE TABLE [dbo].[CourseCategory] (
   [CourseCategoryID] int IDENTITY (1,1) NOT NULL ,
   [ParentCategoryID] int NOT NULL ,
   [ForumID] int NOT NULL ,
   [CourseCategoryName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [CourseCount] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[CourseCategory] WITH NOCHECK ADD
   CONSTRAINT [DF_CourseCategory_ParentCategoryID] DEFAULT (0) FOR [ParentCategoryID] ,
   CONSTRAINT [DF_CourseCategory_ForumID] DEFAULT (0) FOR [ForumID] ,
   CONSTRAINT [DF_CourseCategory_CourseCategoryName] DEFAULT ('') FOR [CourseCategoryName] ,
   CONSTRAINT [DF_CourseCategory_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_CourseCategory_CourseCount] DEFAULT (0) FOR [CourseCount]
GO

ALTER TABLE [dbo].[CourseCategory] WITH NOCHECK ADD
   CONSTRAINT [PK_CourseCategory] PRIMARY KEY NONCLUSTERED
   ([CourseCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CourseCategory_ParentCategoryID]
   ON [dbo].[CourseCategory]
   ([ParentCategoryID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO