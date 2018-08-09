EXEC [dbo].pts_CheckTableRebuild 'ForumModerator'
 GO

ALTER TABLE [dbo].[ForumModerator] WITH NOCHECK ADD
   CONSTRAINT [DF_ForumModerator_ForumID] DEFAULT (0) FOR [ForumID] ,
   CONSTRAINT [DF_ForumModerator_BoardUserID] DEFAULT (0) FOR [BoardUserID]
GO

ALTER TABLE [dbo].[ForumModerator] WITH NOCHECK ADD
   CONSTRAINT [PK_ForumModerator] PRIMARY KEY NONCLUSTERED
   ([ForumModeratorID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ForumModerator_ForumModerator]
   ON [dbo].[ForumModerator]
   ([ForumID], [BoardUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO