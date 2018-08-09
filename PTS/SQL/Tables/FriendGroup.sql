EXEC [dbo].pts_CheckTable 'FriendGroup'
 GO

CREATE TABLE [dbo].[FriendGroup] (
   [FriendGroupID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [FriendGroupName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL 
   ) ON [PRIMARY]
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