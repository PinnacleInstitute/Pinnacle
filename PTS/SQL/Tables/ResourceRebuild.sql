EXEC [dbo].pts_CheckTableRebuild 'Resource'
 GO

ALTER TABLE [dbo].[Resource] WITH NOCHECK ADD
   CONSTRAINT [DF_Resource_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Resource_ResourceType] DEFAULT (0) FOR [ResourceType] ,
   CONSTRAINT [DF_Resource_Share] DEFAULT (0) FOR [Share] ,
   CONSTRAINT [DF_Resource_ShareID] DEFAULT (0) FOR [ShareID] ,
   CONSTRAINT [DF_Resource_IsExclude] DEFAULT (0) FOR [IsExclude]
GO

ALTER TABLE [dbo].[Resource] WITH NOCHECK ADD
   CONSTRAINT [PK_Resource] PRIMARY KEY NONCLUSTERED
   ([ResourceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Resource_MemberID]
   ON [dbo].[Resource]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Resource_ShareID]
   ON [dbo].[Resource]
   ([ShareID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO