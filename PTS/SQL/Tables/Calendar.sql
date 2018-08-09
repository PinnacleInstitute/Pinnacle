EXEC [dbo].pts_CheckTable 'Calendar'
 GO

CREATE TABLE [dbo].[Calendar] (
   [CalendarID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [CalendarName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Layout] int NOT NULL ,
   [IsPrivate] bit NOT NULL ,
   [IsAppt] bit NOT NULL ,
   [IsClass] bit NOT NULL ,
   [IsAssess] bit NOT NULL ,
   [IsGoal] bit NOT NULL ,
   [IsProject] bit NOT NULL ,
   [IsTask] bit NOT NULL ,
   [IsSales] bit NOT NULL ,
   [IsActivities] bit NOT NULL ,
   [IsEvents] bit NOT NULL ,
   [IsService] bit NOT NULL ,
   [IsLead] bit NOT NULL ,
   [Timezone] int NOT NULL ,
   [Seq] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Calendar] WITH NOCHECK ADD
   CONSTRAINT [DF_Calendar_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Calendar_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Calendar_CalendarName] DEFAULT ('') FOR [CalendarName] ,
   CONSTRAINT [DF_Calendar_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Calendar_Layout] DEFAULT (0) FOR [Layout] ,
   CONSTRAINT [DF_Calendar_IsPrivate] DEFAULT (0) FOR [IsPrivate] ,
   CONSTRAINT [DF_Calendar_IsAppt] DEFAULT (0) FOR [IsAppt] ,
   CONSTRAINT [DF_Calendar_IsClass] DEFAULT (0) FOR [IsClass] ,
   CONSTRAINT [DF_Calendar_IsAssess] DEFAULT (0) FOR [IsAssess] ,
   CONSTRAINT [DF_Calendar_IsGoal] DEFAULT (0) FOR [IsGoal] ,
   CONSTRAINT [DF_Calendar_IsProject] DEFAULT (0) FOR [IsProject] ,
   CONSTRAINT [DF_Calendar_IsTask] DEFAULT (0) FOR [IsTask] ,
   CONSTRAINT [DF_Calendar_IsSales] DEFAULT (0) FOR [IsSales] ,
   CONSTRAINT [DF_Calendar_IsActivities] DEFAULT (0) FOR [IsActivities] ,
   CONSTRAINT [DF_Calendar_IsEvents] DEFAULT (0) FOR [IsEvents] ,
   CONSTRAINT [DF_Calendar_IsService] DEFAULT (0) FOR [IsService] ,
   CONSTRAINT [DF_Calendar_IsLead] DEFAULT (0) FOR [IsLead] ,
   CONSTRAINT [DF_Calendar_Timezone] DEFAULT (0) FOR [Timezone] ,
   CONSTRAINT [DF_Calendar_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[Calendar] WITH NOCHECK ADD
   CONSTRAINT [PK_Calendar] PRIMARY KEY NONCLUSTERED
   ([CalendarID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Calendar_CompanyID]
   ON [dbo].[Calendar]
   ([CompanyID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Calendar_MemberID]
   ON [dbo].[Calendar]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO