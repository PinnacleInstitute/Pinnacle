EXEC [dbo].pts_CheckTable 'PeopleEdge'
 GO

CREATE TABLE [dbo].[PeopleEdge] (
   [PeopleEdgeID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[PeopleEdge] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[PeopleEdge] WITH NOCHECK ADD
   CONSTRAINT [PK_PeopleEdge] PRIMARY KEY NONCLUSTERED
   ([PeopleEdgeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO