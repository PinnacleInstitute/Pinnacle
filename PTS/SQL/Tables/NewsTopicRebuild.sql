EXEC [dbo].pts_CheckTableRebuild 'NewsTopic'
 GO

ALTER TABLE [dbo].[NewsTopic] WITH NOCHECK ADD
   CONSTRAINT [DF_NewsTopic_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_NewsTopic_NewsTopicName] DEFAULT ('') FOR [NewsTopicName] ,
   CONSTRAINT [DF_NewsTopic_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_NewsTopic_IsActive] DEFAULT (0) FOR [IsActive]
GO

ALTER TABLE [dbo].[NewsTopic] WITH NOCHECK ADD
   CONSTRAINT [PK_NewsTopic] PRIMARY KEY NONCLUSTERED
   ([NewsTopicID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_NewsTopic_CompanyID]
   ON [dbo].[NewsTopic]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO