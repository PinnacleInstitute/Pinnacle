EXEC [dbo].pts_CheckTableRebuild 'Moption'
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