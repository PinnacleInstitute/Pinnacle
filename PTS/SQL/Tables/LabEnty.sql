EXEC [dbo].pts_CheckTable 'LabEnty'
 GO

CREATE TABLE [dbo].[LabEnty] (
   [LabEntyID] int IDENTITY (1,1) NOT NULL ,
   [EntityName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EntityID] int NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LabEnty] WITH NOCHECK ADD
   CONSTRAINT [DF_LabEnty_EntityName] DEFAULT ('') FOR [EntityName] ,
   CONSTRAINT [DF_LabEnty_EntityID] DEFAULT (0) FOR [EntityID],
   CONSTRAINT [DF_LabEnty_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_LabEnty_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_LabEnty_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_LabEnty_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[LabEnty] WITH NOCHECK ADD
   CONSTRAINT [PK_LabEnty] PRIMARY KEY NONCLUSTERED
   ([LabEntyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO