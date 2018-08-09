EXEC [dbo].pts_CheckTableRebuild 'Broadcast'
 GO

ALTER TABLE [dbo].[Broadcast] WITH NOCHECK ADD
   CONSTRAINT [DF_Broadcast_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Broadcast_FriendGroupID] DEFAULT (0) FOR [FriendGroupID] ,
   CONSTRAINT [DF_Broadcast_BroadcastDate] DEFAULT (0) FOR [BroadcastDate] ,
   CONSTRAINT [DF_Broadcast_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Broadcast_Stories] DEFAULT (0) FOR [Stories] ,
   CONSTRAINT [DF_Broadcast_Friends] DEFAULT (0) FOR [Friends]
GO

ALTER TABLE [dbo].[Broadcast] WITH NOCHECK ADD
   CONSTRAINT [PK_Broadcast] PRIMARY KEY NONCLUSTERED
   ([BroadcastID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Broadcast_MemberID]
   ON [dbo].[Broadcast]
   ([MemberID], [FriendGroupID], [BroadcastDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO