EXEC [dbo].pts_CheckTableRebuild 'AuthLog'
 GO

ALTER TABLE [dbo].[AuthLog] WITH NOCHECK ADD
   CONSTRAINT [DF_AuthLog_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_AuthLog_IP] DEFAULT ('') FOR [IP] ,
   CONSTRAINT [DF_AuthLog_LogDate] DEFAULT (0) FOR [LogDate] ,
   CONSTRAINT [DF_AuthLog_LastDate] DEFAULT (0) FOR [LastDate] ,
   CONSTRAINT [DF_AuthLog_Total] DEFAULT (0) FOR [Total] ,
   CONSTRAINT [DF_AuthLog_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[AuthLog] WITH NOCHECK ADD
   CONSTRAINT [PK_AuthLog] PRIMARY KEY NONCLUSTERED
   ([AuthLogID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_AuthLog_AuthUserID]
   ON [dbo].[AuthLog]
   ([AuthUserID], [IP])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO