EXEC [dbo].pts_CheckTableRebuild 'Comment'
 GO

ALTER TABLE [dbo].[Comment] WITH NOCHECK ADD
   CONSTRAINT [DF_Comment_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Comment_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Comment_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Comment_ReplyID] DEFAULT (0) FOR [ReplyID] ,
   CONSTRAINT [DF_Comment_CommentDate] DEFAULT (0) FOR [CommentDate] ,
   CONSTRAINT [DF_Comment_Msg] DEFAULT ('') FOR [Msg] ,
   CONSTRAINT [DF_Comment_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Comment_Likes] DEFAULT (0) FOR [Likes] ,
   CONSTRAINT [DF_Comment_Dislikes] DEFAULT (0) FOR [Dislikes] ,
   CONSTRAINT [DF_Comment_Bads] DEFAULT (0) FOR [Bads] ,
   CONSTRAINT [DF_Comment_Favorites] DEFAULT (0) FOR [Favorites]
GO

ALTER TABLE [dbo].[Comment] WITH NOCHECK ADD
   CONSTRAINT [PK_Comment] PRIMARY KEY NONCLUSTERED
   ([CommentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Comment_CommentDate]
   ON [dbo].[Comment]
   ([OwnerType], [OwnerID], [CommentDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Comment_Like]
   ON [dbo].[Comment]
   ([OwnerType], [OwnerID], [Likes])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO