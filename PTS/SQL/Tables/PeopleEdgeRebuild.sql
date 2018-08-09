EXEC [dbo].pts_CheckTableRebuild 'PeopleEdge'
 GO

ALTER TABLE [dbo].[PeopleEdge] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[PeopleEdge] WITH NOCHECK ADD
   CONSTRAINT [PK_PeopleEdge] PRIMARY KEY NONCLUSTERED
   ([PeopleEdgeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO