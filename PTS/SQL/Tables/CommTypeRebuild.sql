EXEC [dbo].pts_CheckTableRebuild 'CommType'
 GO

ALTER TABLE [dbo].[CommType] WITH NOCHECK ADD
   CONSTRAINT [DF_CommType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_CommType_CommTypeName] DEFAULT ('') FOR [CommTypeName] ,
   CONSTRAINT [DF_CommType_CommTypeNo] DEFAULT (0) FOR [CommTypeNo]
GO

ALTER TABLE [dbo].[CommType] WITH NOCHECK ADD
   CONSTRAINT [PK_CommType] PRIMARY KEY NONCLUSTERED
   ([CommTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_CommType_CompanyID]
   ON [dbo].[CommType]
   ([CompanyID], [CommTypeNo])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO