EXEC [dbo].pts_CheckTable 'BoardUser'
 GO

CREATE TABLE [dbo].[BoardUser] (
   [BoardUserID] int IDENTITY (1,1) NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [BoardUserName] nvarchar (32) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [BoardUserGroup] int NOT NULL ,
   [IsPublicName] bit NOT NULL ,
   [IsPublicEmail] bit NOT NULL ,
   [Signature] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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