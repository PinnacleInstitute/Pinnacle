EXEC [dbo].pts_CheckTable 'Meeting'
 GO

CREATE TABLE [dbo].[Meeting] (
   [MeetingID] int IDENTITY (1,1) NOT NULL ,
   [VenueID] int NOT NULL ,
   [MeetingDate] datetime NOT NULL ,
   [StartTime] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EndTime] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Limit] int NOT NULL ,
   [Guests] int NOT NULL ,
   [Attended] int NOT NULL ,
   [Notes] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Meeting] WITH NOCHECK ADD
   CONSTRAINT [DF_Meeting_VenueID] DEFAULT (0) FOR [VenueID] ,
   CONSTRAINT [DF_Meeting_MeetingDate] DEFAULT (0) FOR [MeetingDate] ,
   CONSTRAINT [DF_Meeting_StartTime] DEFAULT ('') FOR [StartTime] ,
   CONSTRAINT [DF_Meeting_EndTime] DEFAULT ('') FOR [EndTime] ,
   CONSTRAINT [DF_Meeting_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Meeting_Limit] DEFAULT (0) FOR [Limit] ,
   CONSTRAINT [DF_Meeting_Guests] DEFAULT (0) FOR [Guests] ,
   CONSTRAINT [DF_Meeting_Attended] DEFAULT (0) FOR [Attended] ,
   CONSTRAINT [DF_Meeting_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[Meeting] WITH NOCHECK ADD
   CONSTRAINT [PK_Meeting] PRIMARY KEY NONCLUSTERED
   ([MeetingID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Meeting_VenueID]
   ON [dbo].[Meeting]
   ([VenueID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO