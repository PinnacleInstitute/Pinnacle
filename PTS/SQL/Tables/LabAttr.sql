EXEC [dbo].pts_CheckTable 'LabAttr'
 GO

CREATE TABLE [dbo].[LabAttr] (
   [LabAttrID] int IDENTITY (1,1) NOT NULL ,
   [AttributeName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [AttributeID] int NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[LabAttr] WITH NOCHECK ADD
   CONSTRAINT [DF_LabAttr_AttributeName] DEFAULT ('') FOR [AttributeName] ,
   CONSTRAINT [DF_LabAttr_AttributeID] DEFAULT (0) FOR [AttributeID],
   CONSTRAINT [DF_LabAttr_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_LabAttr_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_LabAttr_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_LabAttr_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[LabAttr] WITH NOCHECK ADD
   CONSTRAINT [PK_LabAttr] PRIMARY KEY NONCLUSTERED
   ([LabAttrID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO