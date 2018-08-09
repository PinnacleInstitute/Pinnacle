EXEC [dbo].pts_CheckTableRebuild 'Shortcut'
 GO

ALTER TABLE [dbo].[Shortcut] WITH NOCHECK ADD
   CONSTRAINT [DF_Shortcut_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Shortcut_EntityID] DEFAULT (0) FOR [EntityID] ,
   CONSTRAINT [DF_Shortcut_ItemID] DEFAULT (0) FOR [ItemID] ,
   CONSTRAINT [DF_Shortcut_ShortcutName] DEFAULT ('') FOR [ShortcutName] ,
   CONSTRAINT [DF_Shortcut_URL] DEFAULT ('') FOR [URL] ,
   CONSTRAINT [DF_Shortcut_IsPinned] DEFAULT (0) FOR [IsPinned] ,
   CONSTRAINT [DF_Shortcut_IsPopup] DEFAULT (0) FOR [IsPopup]
GO

ALTER TABLE [dbo].[Shortcut] WITH NOCHECK ADD
   CONSTRAINT [PK_Shortcut] PRIMARY KEY NONCLUSTERED
   ([ShortcutID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Shortcut_AuthUserID]
   ON [dbo].[Shortcut]
   ([AuthUserID], [IsPinned], [EntityID], [ShortcutName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Shortcut_EntityID]
   ON [dbo].[Shortcut]
   ([EntityID], [ItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO