EXEC [dbo].pts_CheckTable 'Message'
 GO

CREATE TABLE [dbo].[Message] (
   [MessageID] int IDENTITY (1,1) NOT NULL ,
   [ForumID] int NOT NULL ,
   [ParentID] int NOT NULL ,
   [ThreadID] int NOT NULL ,
   [BoardUserID] int NOT NULL ,
   [ModifyID] int NOT NULL ,
   [MessageTitle] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [IsSticky] bit NOT NULL ,
   [Body] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ThreadOrder] int NOT NULL ,
   [Replies] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Message] WITH NOCHECK ADD
   CONSTRAINT [DF_Message_ForumID] DEFAULT (0) FOR [ForumID] ,
   CONSTRAINT [DF_Message_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Message_ThreadID] DEFAULT (0) FOR [ThreadID] ,
   CONSTRAINT [DF_Message_BoardUserID] DEFAULT (0) FOR [BoardUserID] ,
   CONSTRAINT [DF_Message_ModifyID] DEFAULT (0) FOR [ModifyID] ,
   CONSTRAINT [DF_Message_MessageTitle] DEFAULT ('') FOR [MessageTitle] ,
   CONSTRAINT [DF_Message_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Message_IsSticky] DEFAULT (0) FOR [IsSticky] ,
   CONSTRAINT [DF_Message_Body] DEFAULT ('') FOR [Body] ,
   CONSTRAINT [DF_Message_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_Message_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_Message_ThreadOrder] DEFAULT (0) FOR [ThreadOrder] ,
   CONSTRAINT [DF_Message_Replies] DEFAULT (0) FOR [Replies]
GO

ALTER TABLE [dbo].[Message] WITH NOCHECK ADD
   CONSTRAINT [PK_Message] PRIMARY KEY NONCLUSTERED
   ([MessageID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Message_BoardUserID]
   ON [dbo].[Message]
   ([BoardUserID], [ForumID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Message_Forum]
   ON [dbo].[Message]
   ([ChangeDate], [ForumID], [ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Message_Thread]
   ON [dbo].[Message]
   ([ThreadID], [ThreadOrder])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Message_CreateDate]
   ON [dbo].[Message]
   ([CreateDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO