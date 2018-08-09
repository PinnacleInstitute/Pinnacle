EXEC [dbo].pts_CheckTable 'Appt'
 GO

CREATE TABLE [dbo].[Appt] (
   [ApptID] int IDENTITY (1,1) NOT NULL ,
   [CalendarID] int NOT NULL ,
   [ApptName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Location] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Note] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [StartTime] varchar (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [EndTime] varchar (8) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsAllDay] bit NOT NULL ,
   [Status] int NOT NULL ,
   [ApptType] int NOT NULL ,
   [Importance] int NOT NULL ,
   [Show] int NOT NULL ,
   [Reminder] int NOT NULL ,
   [RemindDate] datetime NOT NULL ,
   [Recur] int NOT NULL ,
   [RecurDate] datetime NOT NULL ,
   [IsEdit] bit NOT NULL ,
   [IsPlan] bit NOT NULL 
   ) ON [PRIMARY]
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