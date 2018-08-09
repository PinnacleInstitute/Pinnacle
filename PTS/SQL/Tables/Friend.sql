EXEC [dbo].pts_CheckTable 'Friend'
 GO

CREATE TABLE [dbo].[Friend] (
   [FriendID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [FriendGroupID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FriendDate] datetime NOT NULL ,
   [Status] int NOT NULL ,
   [Zip] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [DOB] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Friend] WITH NOCHECK ADD
   CONSTRAINT [DF_Friend_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Friend_FriendGroupID] DEFAULT (0) FOR [FriendGroupID] ,
   CONSTRAINT [DF_Friend_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Friend_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Friend_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Friend_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Friend_FriendDate] DEFAULT (0) FOR [FriendDate] ,
   CONSTRAINT [DF_Friend_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Friend_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Friend_DOB] DEFAULT (0) FOR [DOB]
GO

ALTER TABLE [dbo].[Friend] WITH NOCHECK ADD
   CONSTRAINT [PK_Friend] PRIMARY KEY NONCLUSTERED
   ([FriendID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Friend_MemberID]
   ON [dbo].[Friend]
   ([MemberID], [FriendGroupID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Friend_Email]
   ON [dbo].[Friend]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO