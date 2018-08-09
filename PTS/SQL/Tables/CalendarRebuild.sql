EXEC [dbo].pts_CheckTableRebuild 'Calendar'
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