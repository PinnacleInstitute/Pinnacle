EXEC [dbo].pts_CheckTableRebuild 'BroadcastNews'
 GO

ALTER TABLE [dbo].[BroadcastNews] WITH NOCHECK ADD
   CONSTRAINT [DF_BroadcastNews_BroadcastID] DEFAULT (0) FOR [BroadcastID] ,
   CONSTRAINT [DF_BroadcastNews_NewsID] DEFAULT (0) FOR [NewsID]
GO

ALTER TABLE [dbo].[BroadcastNews] WITH NOCHECK ADD
   CONSTRAINT [PK_BroadcastNews] PRIMARY KEY NONCLUSTERED
   ([BroadcastNewsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BroadcastNews_BroadcastID]
   ON [dbo].[BroadcastNews]
   ([BroadcastID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BroadcastNews_NewsID]
   ON [dbo].[BroadcastNews]
   ([NewsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO