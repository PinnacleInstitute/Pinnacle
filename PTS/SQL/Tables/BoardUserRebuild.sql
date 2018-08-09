EXEC [dbo].pts_CheckTableRebuild 'BoardUser'
 GO

ALTER TABLE [dbo].[BoardUser] WITH NOCHECK ADD
   CONSTRAINT [DF_BoardUser_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_BoardUser_BoardUserName] DEFAULT ('') FOR [BoardUserName] ,
   CONSTRAINT [DF_BoardUser_BoardUserGroup] DEFAULT (0) FOR [BoardUserGroup] ,
   CONSTRAINT [DF_BoardUser_IsPublicName] DEFAULT (0) FOR [IsPublicName] ,
   CONSTRAINT [DF_BoardUser_IsPublicEmail] DEFAULT (0) FOR [IsPublicEmail] ,
   CONSTRAINT [DF_BoardUser_Signature] DEFAULT ('') FOR [Signature]
GO

ALTER TABLE [dbo].[BoardUser] WITH NOCHECK ADD
   CONSTRAINT [PK_BoardUser] PRIMARY KEY NONCLUSTERED
   ([BoardUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BoardUser_AuthUserID]
   ON [dbo].[BoardUser]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO