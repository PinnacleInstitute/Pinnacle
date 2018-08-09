EXEC [dbo].pts_CheckTable 'AdTrack'
 GO

CREATE TABLE [dbo].[AdTrack] (
   [AdTrackID] int IDENTITY (1,1) NOT NULL ,
   [AdID] int NOT NULL ,
   [Place] int NOT NULL ,
   [RefID] int NOT NULL ,
   [UType] int NOT NULL ,
   [UID] int NOT NULL ,
   [PlaceDate] datetime NOT NULL ,
   [ClickDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[AdTrack] WITH NOCHECK ADD
   CONSTRAINT [DF_AdTrack_AdID] DEFAULT (0) FOR [AdID] ,
   CONSTRAINT [DF_AdTrack_Place] DEFAULT (0) FOR [Place] ,
   CONSTRAINT [DF_AdTrack_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_AdTrack_UType] DEFAULT (0) FOR [UType] ,
   CONSTRAINT [DF_AdTrack_UID] DEFAULT (0) FOR [UID] ,
   CONSTRAINT [DF_AdTrack_PlaceDate] DEFAULT (0) FOR [PlaceDate] ,
   CONSTRAINT [DF_AdTrack_ClickDate] DEFAULT (0) FOR [ClickDate]
GO

ALTER TABLE [dbo].[AdTrack] WITH NOCHECK ADD
   CONSTRAINT [PK_AdTrack] PRIMARY KEY NONCLUSTERED
   ([AdTrackID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AdTrack_AdID]
   ON [dbo].[AdTrack]
   ([AdID], [PlaceDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AdTrack_PlaceDate]
   ON [dbo].[AdTrack]
   ([PlaceDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO