EXEC [dbo].pts_CheckTable 'Venue'
 GO

CREATE TABLE [dbo].[Venue] (
   [VenueID] int IDENTITY (1,1) NOT NULL ,
   [SeminarID] int NOT NULL ,
   [VenueName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Street1] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street2] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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