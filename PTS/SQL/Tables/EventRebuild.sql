EXEC [dbo].pts_CheckTableRebuild 'Event'
 GO

ALTER TABLE [dbo].[Event] WITH NOCHECK ADD
   CONSTRAINT [DF_Event_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Event_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Event_EventName] DEFAULT ('') FOR [EventName] ,
   CONSTRAINT [DF_Event_EventDate] DEFAULT (0) FOR [EventDate] ,
   CONSTRAINT [DF_Event_EventType] DEFAULT (0) FOR [EventType] ,
   CONSTRAINT [DF_Event_RemindDays] DEFAULT (0) FOR [RemindDays] ,
   CONSTRAINT [DF_Event_RemindDate] DEFAULT (0) FOR [RemindDate] ,
   CONSTRAINT [DF_Event_Recur] DEFAULT (0) FOR [Recur]
GO

ALTER TABLE [dbo].[Event] WITH NOCHECK ADD
   CONSTRAINT [PK_Event] PRIMARY KEY NONCLUSTERED
   ([EventID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Event_Owner]
   ON [dbo].[Event]
   ([OwnerType], [OwnerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Event_EventDate]
   ON [dbo].[Event]
   ([EventDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Event_RemindDate]
   ON [dbo].[Event]
   ([OwnerType], [RemindDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO