EXEC [dbo].pts_CheckTableRebuild 'FriendGroup'
 GO

ALTER TABLE [dbo].[FriendGroup] WITH NOCHECK ADD
   CONSTRAINT [DF_FriendGroup_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_FriendGroup_FriendGroupName] DEFAULT ('') FOR [FriendGroupName] ,
   CONSTRAINT [DF_FriendGroup_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[FriendGroup] WITH NOCHECK ADD
   CONSTRAINT [PK_FriendGroup] PRIMARY KEY NONCLUSTERED
   ([FriendGroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_FriendGroup_MemberID]
   ON [dbo].[FriendGroup]
   ([MemberID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO