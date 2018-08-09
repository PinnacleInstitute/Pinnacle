EXEC [dbo].pts_CheckTableRebuild 'Venue'
 GO

ALTER TABLE [dbo].[Venue] WITH NOCHECK ADD
   CONSTRAINT [DF_Venue_SeminarID] DEFAULT (0) FOR [SeminarID] ,
   CONSTRAINT [DF_Venue_VenueName] DEFAULT ('') FOR [VenueName] ,
   CONSTRAINT [DF_Venue_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Venue_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Venue_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Venue_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Venue_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Venue_Zip] DEFAULT ('') FOR [Zip]
GO

ALTER TABLE [dbo].[Venue] WITH NOCHECK ADD
   CONSTRAINT [PK_Venue] PRIMARY KEY NONCLUSTERED
   ([VenueID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Venue_SeminarID]
   ON [dbo].[Venue]
   ([SeminarID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO