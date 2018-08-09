EXEC [dbo].pts_CheckTable 'Forum'
 GO

CREATE TABLE [dbo].[Forum] (
   [ForumID] int IDENTITY (1,1) NOT NULL ,
   [ParentID] int NOT NULL ,
   [ForumName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [Description] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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