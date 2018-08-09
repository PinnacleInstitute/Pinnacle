EXEC [dbo].pts_CheckTableRebuild 'Attendee'
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