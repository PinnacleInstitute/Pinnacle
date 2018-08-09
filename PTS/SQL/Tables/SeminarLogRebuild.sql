EXEC [dbo].pts_CheckTableRebuild 'SeminarLog'
 GO

ALTER TABLE [dbo].[SeminarLog] WITH NOCHECK ADD
   CONSTRAINT [DF_SeminarLog_SeminarID] DEFAULT (0) FOR [SeminarID] ,
   CONSTRAINT [DF_SeminarLog_LogDate] DEFAULT (0) FOR [LogDate]
GO

ALTER TABLE [dbo].[SeminarLog] WITH NOCHECK ADD
   CONSTRAINT [PK_SeminarLog] PRIMARY KEY NONCLUSTERED
   ([SeminarLogID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SeminarLog_SeminarLogID]
   ON [dbo].[SeminarLog]
   ([SeminarID], [LogDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO