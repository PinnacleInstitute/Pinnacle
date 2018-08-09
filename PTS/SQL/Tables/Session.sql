EXEC [dbo].pts_CheckTable 'Session'
 GO

CREATE TABLE [dbo].[Session] (
   [SessionID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [CourseID] int NOT NULL ,
   [OrgCourseID] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [RegisterDate] datetime NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [CompleteDate] datetime NOT NULL ,
   [Grade] int NOT NULL ,
   [Feedback] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Rating1] int NOT NULL ,
   [Rating2] int NOT NULL ,
   [Rating3] int NOT NULL ,
   [Rating4] int NOT NULL ,
   [TotalRating] int NOT NULL ,
   [URLOption] int NOT NULL ,
   [Time] int NOT NULL ,
   [Times] decimal (10, 8) NOT NULL ,
   [IsInactive] bit NOT NULL ,
   [TrainerScore] int NOT NULL ,
   [CommStatus] int NOT NULL ,
   [Apply] int NOT NULL ,
   [Recommend1] int NOT NULL ,
   [Recommend2] int NOT NULL ,
   [Recommend3] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Session] WITH NOCHECK ADD
   CONSTRAINT [DF_Session_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Session_CourseID] DEFAULT (0) FOR [CourseID] ,
   CONSTRAINT [DF_Session_OrgCourseID] DEFAULT (0) FOR [OrgCourseID] ,
   CONSTRAINT [DF_Session_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Session_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Session_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Session_RegisterDate] DEFAULT (0) FOR [RegisterDate] ,
   CONSTRAINT [DF_Session_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Session_CompleteDate] DEFAULT (0) FOR [CompleteDate] ,
   CONSTRAINT [DF_Session_Grade] DEFAULT (0) FOR [Grade] ,
   CONSTRAINT [DF_Session_Feedback] DEFAULT ('') FOR [Feedback] ,
   CONSTRAINT [DF_Session_Rating1] DEFAULT (0) FOR [Rating1] ,
   CONSTRAINT [DF_Session_Rating2] DEFAULT (0) FOR [Rating2] ,
   CONSTRAINT [DF_Session_Rating3] DEFAULT (0) FOR [Rating3] ,
   CONSTRAINT [DF_Session_Rating4] DEFAULT (0) FOR [Rating4] ,
   CONSTRAINT [DF_Session_TotalRating] DEFAULT (0) FOR [TotalRating] ,
   CONSTRAINT [DF_Session_URLOption] DEFAULT (0) FOR [URLOption] ,
   CONSTRAINT [DF_Session_Time] DEFAULT (0) FOR [Time] ,
   CONSTRAINT [DF_Session_Times] DEFAULT (0) FOR [Times] ,
   CONSTRAINT [DF_Session_IsInactive] DEFAULT (0) FOR [IsInactive] ,
   CONSTRAINT [DF_Session_TrainerScore] DEFAULT (0) FOR [TrainerScore] ,
   CONSTRAINT [DF_Session_CommStatus] DEFAULT (0) FOR [CommStatus] ,
   CONSTRAINT [DF_Session_Apply] DEFAULT (0) FOR [Apply] ,
   CONSTRAINT [DF_Session_Recommend1] DEFAULT (0) FOR [Recommend1] ,
   CONSTRAINT [DF_Session_Recommend2] DEFAULT (0) FOR [Recommend2] ,
   CONSTRAINT [DF_Session_Recommend3] DEFAULT (0) FOR [Recommend3]
GO

ALTER TABLE [dbo].[Session] WITH NOCHECK ADD
   CONSTRAINT [PK_Session] PRIMARY KEY NONCLUSTERED
   ([SessionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Session_MemberID]
   ON [dbo].[Session]
   ([MemberID], [CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Session_CourseID]
   ON [dbo].[Session]
   ([CourseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Session_TrainerScore]
   ON [dbo].[Session]
   ([TrainerScore], [CompleteDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Session_MemberOrgCourse]
   ON [dbo].[Session]
   ([MemberID], [OrgCourseID], [IsInactive])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO