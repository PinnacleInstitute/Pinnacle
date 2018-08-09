EXEC [dbo].pts_CheckTable 'Attendee'
 GO

CREATE TABLE [dbo].[Attendee] (
   [AttendeeID] int IDENTITY (1,1) NOT NULL ,
   [SeminarID] int NOT NULL ,
   [MeetingID] int NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street1] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street2] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Guests] int NOT NULL ,
   [IP] varchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [RegisterDate] datetime NOT NULL ,
   [Attended] int NOT NULL ,
   [Refer] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Attendee] WITH NOCHECK ADD
   CONSTRAINT [DF_Attendee_SeminarID] DEFAULT (0) FOR [SeminarID] ,
   CONSTRAINT [DF_Attendee_MeetingID] DEFAULT (0) FOR [MeetingID] ,
   CONSTRAINT [DF_Attendee_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Attendee_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Attendee_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Attendee_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Attendee_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Attendee_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Attendee_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Attendee_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Attendee_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Attendee_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Attendee_Guests] DEFAULT (0) FOR [Guests] ,
   CONSTRAINT [DF_Attendee_IP] DEFAULT ('') FOR [IP] ,
   CONSTRAINT [DF_Attendee_RegisterDate] DEFAULT (0) FOR [RegisterDate] ,
   CONSTRAINT [DF_Attendee_Attended] DEFAULT (0) FOR [Attended] ,
   CONSTRAINT [DF_Attendee_Refer] DEFAULT ('') FOR [Refer]
GO

ALTER TABLE [dbo].[Attendee] WITH NOCHECK ADD
   CONSTRAINT [PK_Attendee] PRIMARY KEY NONCLUSTERED
   ([AttendeeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Attendee_SeminarID]
   ON [dbo].[Attendee]
   ([SeminarID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Attendee_MeetingID]
   ON [dbo].[Attendee]
   ([MeetingID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO