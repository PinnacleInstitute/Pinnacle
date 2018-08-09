EXEC [dbo].pts_CheckTable 'Favorite'
 GO

CREATE TABLE [dbo].[Favorite] (
   [FavoriteID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [RefType] int NOT NULL ,
   [RefID] int NOT NULL ,
   [FavoriteDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Favorite] WITH NOCHECK ADD
   CONSTRAINT [DF_Favorite_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Favorite_RefType] DEFAULT (0) FOR [RefType] ,
   CONSTRAINT [DF_Favorite_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Favorite_FavoriteDate] DEFAULT (0) FOR [FavoriteDate]
GO

ALTER TABLE [dbo].[Favorite] WITH NOCHECK ADD
   CONSTRAINT [PK_Favorite] PRIMARY KEY NONCLUSTERED
   ([FavoriteID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Favorite_Member]
   ON [dbo].[Favorite]
   ([MemberID], [RefType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Favorite_Reference]
   ON [dbo].[Favorite]
   ([RefType], [RefID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO