EXEC [dbo].pts_CheckTableRebuild 'DownTitle'
 GO

ALTER TABLE [dbo].[DownTitle] WITH NOCHECK ADD
   CONSTRAINT [DF_DownTitle_Line] DEFAULT (0) FOR [Line] ,
   CONSTRAINT [DF_DownTitle_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_DownTitle_Leg] DEFAULT (0) FOR [Leg] ,
   CONSTRAINT [DF_DownTitle_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_DownTitle_Cnt] DEFAULT (0) FOR [Cnt]
GO

ALTER TABLE [dbo].[DownTitle] WITH NOCHECK ADD
   CONSTRAINT [PK_DownTitle] PRIMARY KEY NONCLUSTERED
   ([DownTitleID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_DownTitle_Member]
   ON [dbo].[DownTitle]
   ([Line], [MemberID], [Leg], [Title])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO