EXEC [dbo].pts_CheckTableRebuild 'FolderItem'
 GO

ALTER TABLE [dbo].[FolderItem] WITH NOCHECK ADD
   CONSTRAINT [DF_FolderItem_FolderID] DEFAULT (0) FOR [FolderID] ,
   CONSTRAINT [DF_FolderItem_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_FolderItem_Entity] DEFAULT (0) FOR [Entity] ,
   CONSTRAINT [DF_FolderItem_ItemID] DEFAULT (0) FOR [ItemID] ,
   CONSTRAINT [DF_FolderItem_ItemDate] DEFAULT (0) FOR [ItemDate] ,
   CONSTRAINT [DF_FolderItem_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[FolderItem] WITH NOCHECK ADD
   CONSTRAINT [PK_FolderItem] PRIMARY KEY NONCLUSTERED
   ([FolderItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_FolderItem_FolderID]
   ON [dbo].[FolderItem]
   ([FolderID], [MemberID], [Entity], [ItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_FolderItem_Entity]
   ON [dbo].[FolderItem]
   ([Entity], [ItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_FolderItem_ItemDate]
   ON [dbo].[FolderItem]
   ([FolderID], [ItemDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO