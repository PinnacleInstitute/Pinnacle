EXEC [dbo].pts_CheckTable 'Label'
 GO

CREATE TABLE [dbo].[Label] (
   [LabelID] int IDENTITY (1,1) NOT NULL ,
   [EntityID] int NOT NULL ,
   [AttributeID] int NOT NULL ,
   [ItemID] int NOT NULL ,
   [LanguageCode] nvarchar (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Text] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Label] WITH NOCHECK ADD
   CONSTRAINT [DF_Label_EntityID] DEFAULT (0) FOR [EntityID] ,
   CONSTRAINT [DF_Label_AttributeID] DEFAULT (0) FOR [AttributeID] ,
   CONSTRAINT [DF_Label_ItemID] DEFAULT (0) FOR [ItemID] ,
   CONSTRAINT [DF_Label_LanguageCode] DEFAULT ('') FOR [LanguageCode] ,
   CONSTRAINT [DF_Label_Text] DEFAULT ('') FOR [Text],
   CONSTRAINT [DF_Label_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_Label_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_Label_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_Label_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[Label] WITH NOCHECK ADD
   CONSTRAINT [PK_Label] PRIMARY KEY NONCLUSTERED
   ([LabelID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Label_Label]
   ON [dbo].[Label]
   ([EntityID], [LanguageCode], [AttributeID], [ItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Label_Attribute]
   ON [dbo].[Label]
   ([EntityID], [LanguageCode], [ItemID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO