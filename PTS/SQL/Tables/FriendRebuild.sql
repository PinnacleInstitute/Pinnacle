EXEC [dbo].pts_CheckTableRebuild 'Friend'
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