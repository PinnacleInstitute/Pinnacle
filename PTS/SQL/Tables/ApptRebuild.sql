EXEC [dbo].pts_CheckTableRebuild 'Appt'
 GO

ALTER TABLE [dbo].[Appt] WITH NOCHECK ADD
   CONSTRAINT [DF_Appt_CalendarID] DEFAULT (0) FOR [CalendarID] ,
   CONSTRAINT [DF_Appt_ApptName] DEFAULT ('') FOR [ApptName] ,
   CONSTRAINT [DF_Appt_Location] DEFAULT ('') FOR [Location] ,
   CONSTRAINT [DF_Appt_Note] DEFAULT ('') FOR [Note] ,
   CONSTRAINT [DF_Appt_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Appt_StartTime] DEFAULT ('') FOR [StartTime] ,
   CONSTRAINT [DF_Appt_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Appt_EndTime] DEFAULT ('') FOR [EndTime] ,
   CONSTRAINT [DF_Appt_IsAllDay] DEFAULT (0) FOR [IsAllDay] ,
   CONSTRAINT [DF_Appt_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Appt_ApptType] DEFAULT (0) FOR [ApptType] ,
   CONSTRAINT [DF_Appt_Importance] DEFAULT (0) FOR [Importance] ,
   CONSTRAINT [DF_Appt_Show] DEFAULT (0) FOR [Show] ,
   CONSTRAINT [DF_Appt_Reminder] DEFAULT (0) FOR [Reminder] ,
   CONSTRAINT [DF_Appt_RemindDate] DEFAULT (0) FOR [RemindDate] ,
   CONSTRAINT [DF_Appt_Recur] DEFAULT (0) FOR [Recur] ,
   CONSTRAINT [DF_Appt_RecurDate] DEFAULT (0) FOR [RecurDate] ,
   CONSTRAINT [DF_Appt_IsEdit] DEFAULT (0) FOR [IsEdit] ,
   CONSTRAINT [DF_Appt_IsPlan] DEFAULT (0) FOR [IsPlan]
GO

ALTER TABLE [dbo].[Appt] WITH NOCHECK ADD
   CONSTRAINT [PK_Appt] PRIMARY KEY NONCLUSTERED
   ([ApptID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Appt_CalendarID]
   ON [dbo].[Appt]
   ([CalendarID], [StartDate], [EndDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Appt_RemindDate]
   ON [dbo].[Appt]
   ([RemindDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO