EXEC [dbo].pts_CheckTableRebuild 'LeadLog'
 GO

ALTER TABLE [dbo].[LeadLog] WITH NOCHECK ADD
   CONSTRAINT [DF_LeadLog_LeadPageID] DEFAULT (0) FOR [LeadPageID] ,
   CONSTRAINT [DF_LeadLog_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_LeadLog_AffiliateID] DEFAULT (0) FOR [AffiliateID] ,
   CONSTRAINT [DF_LeadLog_LogDate] DEFAULT (0) FOR [LogDate]
GO

ALTER TABLE [dbo].[LeadLog] WITH NOCHECK ADD
   CONSTRAINT [PK_LeadLog] PRIMARY KEY NONCLUSTERED
   ([LeadLogID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadLog_LeadLogID]
   ON [dbo].[LeadLog]
   ([LeadPageID], [LogDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadLog_MemberID]
   ON [dbo].[LeadLog]
   ([LeadPageID], [MemberID], [LogDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_LeadLog_AffiliateID]
   ON [dbo].[LeadLog]
   ([LeadPageID], [AffiliateID], [LogDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO