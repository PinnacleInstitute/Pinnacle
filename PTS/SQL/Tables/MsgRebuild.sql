EXEC [dbo].pts_CheckTableRebuild 'Msg'
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