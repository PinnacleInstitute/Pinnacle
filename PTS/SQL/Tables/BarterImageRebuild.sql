EXEC [dbo].pts_CheckTableRebuild 'BarterImage'
 GO

ALTER TABLE [dbo].[BarterImage] WITH NOCHECK ADD
   CONSTRAINT [DF_BarterImage_BarterAdID] DEFAULT (0) FOR [BarterAdID] ,
   CONSTRAINT [DF_BarterImage_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_BarterImage_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_BarterImage_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_BarterImage_Ext] DEFAULT ('') FOR [Ext]
GO

ALTER TABLE [dbo].[BarterImage] WITH NOCHECK ADD
   CONSTRAINT [PK_BarterImage] PRIMARY KEY NONCLUSTERED
   ([BarterImageID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_BarterImage_BarterAdID]
   ON [dbo].[BarterImage]
   ([BarterAdID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO