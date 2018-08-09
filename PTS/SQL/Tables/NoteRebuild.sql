EXEC [dbo].pts_CheckTableRebuild 'Note'
 GO

ALTER TABLE [dbo].[Note] WITH NOCHECK ADD
   CONSTRAINT [DF_Note_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Note_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Note_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Note_NoteDate] DEFAULT (0) FOR [NoteDate] ,
   CONSTRAINT [DF_Note_Notes] DEFAULT ('') FOR [Notes] ,
   CONSTRAINT [DF_Note_IsLocked] DEFAULT (0) FOR [IsLocked] ,
   CONSTRAINT [DF_Note_IsFrozen] DEFAULT (0) FOR [IsFrozen] ,
   CONSTRAINT [DF_Note_IsReminder] DEFAULT (0) FOR [IsReminder]
GO

ALTER TABLE [dbo].[Note] WITH NOCHECK ADD
   CONSTRAINT [PK_Note] PRIMARY KEY NONCLUSTERED
   ([NoteID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Note_Owner]
   ON [dbo].[Note]
   ([OwnerType], [OwnerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Note_AuthUserID]
   ON [dbo].[Note]
   ([AuthUserID], [NoteDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Note_NoteDate]
   ON [dbo].[Note]
   ([NoteDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO