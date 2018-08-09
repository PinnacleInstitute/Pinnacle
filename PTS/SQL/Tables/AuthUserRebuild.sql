EXEC [dbo].pts_CheckTableRebuild 'AuthUser'
 GO

ALTER TABLE [dbo].[AuthUser] WITH NOCHECK ADD
   CONSTRAINT [DF_AuthUser_Logon] DEFAULT ('') FOR [Logon] ,
   CONSTRAINT [DF_AuthUser_Password] DEFAULT ('') FOR [Password] ,
   CONSTRAINT [DF_AuthUser_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_AuthUser_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_AuthUser_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_AuthUser_UserType] DEFAULT (0) FOR [UserType] ,
   CONSTRAINT [DF_AuthUser_UserGroup] DEFAULT (0) FOR [UserGroup] ,
   CONSTRAINT [DF_AuthUser_UserStatus] DEFAULT (0) FOR [UserStatus] ,
   CONSTRAINT [DF_AuthUser_UserKey] DEFAULT ('') FOR [UserKey] ,
   CONSTRAINT [DF_AuthUser_UserCode] DEFAULT ('') FOR [UserCode],
   CONSTRAINT [DF_AuthUser_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_AuthUser_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_AuthUser_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_AuthUser_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[AuthUser] WITH NOCHECK ADD
   CONSTRAINT [PK_AuthUser] PRIMARY KEY NONCLUSTERED
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE UNIQUE INDEX [UI_AuthUser_Logon]
   ON [dbo].[AuthUser]
   ([Logon])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AuthUser_Email]
   ON [dbo].[AuthUser]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AuthUser_NameFirst]
   ON [dbo].[AuthUser]
   ([NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO