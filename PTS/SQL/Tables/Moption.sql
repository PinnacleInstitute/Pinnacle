EXEC [dbo].pts_CheckTable 'Moption'
 GO

CREATE TABLE [dbo].[Moption] (
   [MoptionID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [IsActivity] bit NOT NULL ,
   [ActivityTracks] varchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TrackTheme] int NOT NULL ,
   [MenuColors] varchar (200) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Portal] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Options0] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Options1] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Options2] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Options3] varchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Moption] WITH NOCHECK ADD
   CONSTRAINT [DF_Moption_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Moption_IsActivity] DEFAULT (0) FOR [IsActivity] ,
   CONSTRAINT [DF_Moption_ActivityTracks] DEFAULT ('') FOR [ActivityTracks] ,
   CONSTRAINT [DF_Moption_TrackTheme] DEFAULT (0) FOR [TrackTheme] ,
   CONSTRAINT [DF_Moption_MenuColors] DEFAULT ('') FOR [MenuColors] ,
   CONSTRAINT [DF_Moption_Portal] DEFAULT ('') FOR [Portal] ,
   CONSTRAINT [DF_Moption_Options0] DEFAULT ('') FOR [Options0] ,
   CONSTRAINT [DF_Moption_Options1] DEFAULT ('') FOR [Options1] ,
   CONSTRAINT [DF_Moption_Options2] DEFAULT ('') FOR [Options2] ,
   CONSTRAINT [DF_Moption_Options3] DEFAULT ('') FOR [Options3]
GO

ALTER TABLE [dbo].[Moption] WITH NOCHECK ADD
   CONSTRAINT [PK_Moption] PRIMARY KEY NONCLUSTERED
   ([MoptionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Moption_MemberID]
   ON [dbo].[Moption]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO