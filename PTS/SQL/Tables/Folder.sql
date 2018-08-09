EXEC [dbo].pts_CheckTable 'Folder'
 GO

CREATE TABLE [dbo].[Folder] (
   [FolderID] int IDENTITY (1,1) NOT NULL ,
   [ParentID] int NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [DripCampaignID] int NOT NULL ,
   [FolderName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Entity] int NOT NULL ,
   [Seq] int NOT NULL ,
   [IsShare] bit NOT NULL ,
   [Virtual] int NOT NULL ,
   [Data] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Folder] WITH NOCHECK ADD
   CONSTRAINT [DF_Folder_ParentID] DEFAULT (0) FOR [ParentID] ,
   CONSTRAINT [DF_Folder_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Folder_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Folder_DripCampaignID] DEFAULT (0) FOR [DripCampaignID] ,
   CONSTRAINT [DF_Folder_FolderName] DEFAULT ('') FOR [FolderName] ,
   CONSTRAINT [DF_Folder_Entity] DEFAULT (0) FOR [Entity] ,
   CONSTRAINT [DF_Folder_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_Folder_IsShare] DEFAULT (0) FOR [IsShare] ,
   CONSTRAINT [DF_Folder_Virtual] DEFAULT (0) FOR [Virtual] ,
   CONSTRAINT [DF_Folder_Data] DEFAULT ('') FOR [Data]
GO

ALTER TABLE [dbo].[Folder] WITH NOCHECK ADD
   CONSTRAINT [PK_Folder] PRIMARY KEY NONCLUSTERED
   ([FolderID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Folder_ParentID]
   ON [dbo].[Folder]
   ([ParentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Folder_CompanyID]
   ON [dbo].[Folder]
   ([CompanyID], [Entity], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Folder_DripCampaignID]
   ON [dbo].[Folder]
   ([DripCampaignID], [Virtual])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO