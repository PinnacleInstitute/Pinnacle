EXEC [dbo].pts_CheckTableRebuild 'Forum'
 GO

ALTER TABLE [dbo].[Forum] WITH NOCHECK ADD
   CONSTRAINT [DF_Forum_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Forum_ForumName] DEFAULT ('') FOR [ForumName] ,
   CONSTRAINT [DF_Forum_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Forum_Description] DEFAULT ('') FOR [Description]
GO

ALTER TABLE [dbo].[Forum] WITH NOCHECK ADD
   CONSTRAINT [PK_Forum] PRIMARY KEY NONCLUSTERED
   ([ForumID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Forum_ParentID]
   ON [dbo].[Forum]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO