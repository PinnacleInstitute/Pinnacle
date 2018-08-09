EXEC [dbo].pts_CheckTable 'ProspectType'
 GO

CREATE TABLE [dbo].[ProspectType] (
   [ProspectTypeID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [ProspectTypeName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Seq] int NOT NULL ,
   [InputOptions] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[ProspectType] WITH NOCHECK ADD
   CONSTRAINT [DF_ProspectType_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_ProspectType_ProspectTypeName] DEFAULT ('') FOR [ProspectTypeName] ,
   CONSTRAINT [DF_ProspectType_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_ProspectType_InputOptions] DEFAULT ('') FOR [InputOptions]
GO

ALTER TABLE [dbo].[ProspectType] WITH NOCHECK ADD
   CONSTRAINT [PK_ProspectType] PRIMARY KEY NONCLUSTERED
   ([ProspectTypeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProspectType_CompanyID]
   ON [dbo].[ProspectType]
   ([CompanyID], [Seq])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO