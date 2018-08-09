EXEC [dbo].pts_CheckTable 'Msg'
 GO

CREATE TABLE [dbo].[Msg] (
   [MsgID] int IDENTITY (1,1) NOT NULL ,
   [OwnerType] int NOT NULL ,
   [OwnerID] int NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [MsgDate] datetime NOT NULL ,
   [Subject] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Message] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Msg] WITH NOCHECK ADD
   CONSTRAINT [DF_Msg_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Msg_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Msg_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Msg_MsgDate] DEFAULT (0) FOR [MsgDate] ,
   CONSTRAINT [DF_Msg_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Msg_Message] DEFAULT ('') FOR [Message] ,
   CONSTRAINT [DF_Msg_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[Msg] WITH NOCHECK ADD
   CONSTRAINT [PK_Msg] PRIMARY KEY NONCLUSTERED
   ([MsgID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Msg_Owner]
   ON [dbo].[Msg]
   ([OwnerType], [OwnerID], [MsgDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Msg_AuthUserID]
   ON [dbo].[Msg]
   ([AuthUserID], [MsgDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Msg_MsgDate]
   ON [dbo].[Msg]
   ([MsgDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO