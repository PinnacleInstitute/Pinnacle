EXEC [dbo].pts_CheckTableRebuild 'Mail'
 GO

ALTER TABLE [dbo].[Mail] WITH NOCHECK ADD
   CONSTRAINT [DF_Mail_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Mail_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Mail_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Mail_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Mail_MailFrom] DEFAULT ('') FOR [MailFrom] ,
   CONSTRAINT [DF_Mail_MailTo] DEFAULT ('') FOR [MailTo] ,
   CONSTRAINT [DF_Mail_CC] DEFAULT ('') FOR [CC] ,
   CONSTRAINT [DF_Mail_BCC] DEFAULT ('') FOR [BCC] ,
   CONSTRAINT [DF_Mail_MailDate] DEFAULT (0) FOR [MailDate]
GO

ALTER TABLE [dbo].[Mail] WITH NOCHECK ADD
   CONSTRAINT [PK_Mail] PRIMARY KEY NONCLUSTERED
   ([MailID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Mail_OwnerID]
   ON [dbo].[Mail]
   ([OwnerType], [OwnerID], [MailDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO