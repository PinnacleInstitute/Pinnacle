EXEC [dbo].pts_CheckTableRebuild 'ProjectType'
 GO

ALTER TABLE [dbo].[ProjectType] WITH NOCHECK ADD
   CONSTRAINT [DF_ProjectType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_ProjectType_ProjectTypeName] DEFAULT ('') FOR [ProjectTypeName] ,
   CONSTRAINT [DF_ProjectType_Seq] DEFAULT (0) FOR [Seq]
GO

ALTER TABLE [dbo].[ProjectType] WITH NOCHECK ADD
   CONSTRAINT [PK_ProjectType] PRIMARY KEY NONCLUSTERED
   ([ProjectTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProjectType_CompanyID]
   ON [dbo].[ProjectType]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO