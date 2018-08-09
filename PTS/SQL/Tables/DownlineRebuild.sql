EXEC [dbo].pts_CheckTableRebuild 'Downline'
 GO

ALTER TABLE [dbo].[Downline] WITH NOCHECK ADD
   CONSTRAINT [DF_Downline_Line] DEFAULT (0) FOR [Line] ,
   CONSTRAINT [DF_Downline_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Downline_ChildID] DEFAULT (0) FOR [ChildID] ,
   CONSTRAINT [DF_Downline_Position] DEFAULT (0) FOR [Position] ,
   CONSTRAINT [DF_Downline_IsLocked] DEFAULT (0) FOR [IsLocked]
GO

ALTER TABLE [dbo].[Downline] WITH NOCHECK ADD
   CONSTRAINT [PK_Downline] PRIMARY KEY NONCLUSTERED
   ([DownlineID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Downline_Parent]
   ON [dbo].[Downline]
   ([Line], [ParentID], [Position])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Downline_Child]
   ON [dbo].[Downline]
   ([Line], [ChildID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO