EXEC [dbo].pts_CheckTable 'Ad'
 GO

CREATE TABLE [dbo].[Ad] (
   [AdID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [MemberID] int NOT NULL ,
   [AdName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Msg] nvarchar (2000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Placement] int NOT NULL ,
   [RefID] int NOT NULL ,
   [Priority] int NOT NULL ,
   [POrder] int NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [MTA] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [StartAge] int NOT NULL ,
   [EndAge] int NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [MaxPlace] int NOT NULL ,
   [Places] int NOT NULL ,
   [Clicks] int NOT NULL ,
   [Rotation] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Weight] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Ad] WITH NOCHECK ADD
   CONSTRAINT [DF_Ad_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Ad_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Ad_AdName] DEFAULT ('') FOR [AdName] ,
   CONSTRAINT [DF_Ad_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Ad_Msg] DEFAULT ('') FOR [Msg] ,
   CONSTRAINT [DF_Ad_Placement] DEFAULT (0) FOR [Placement] ,
   CONSTRAINT [DF_Ad_RefID] DEFAULT (0) FOR [RefID] ,
   CONSTRAINT [DF_Ad_Priority] DEFAULT (0) FOR [Priority] ,
   CONSTRAINT [DF_Ad_POrder] DEFAULT (0) FOR [POrder] ,
   CONSTRAINT [DF_Ad_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Ad_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Ad_MTA] DEFAULT ('') FOR [MTA] ,
   CONSTRAINT [DF_Ad_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Ad_StartAge] DEFAULT (0) FOR [StartAge] ,
   CONSTRAINT [DF_Ad_EndAge] DEFAULT (0) FOR [EndAge] ,
   CONSTRAINT [DF_Ad_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Ad_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Ad_MaxPlace] DEFAULT (0) FOR [MaxPlace] ,
   CONSTRAINT [DF_Ad_Places] DEFAULT (0) FOR [Places] ,
   CONSTRAINT [DF_Ad_Clicks] DEFAULT (0) FOR [Clicks] ,
   CONSTRAINT [DF_Ad_Rotation] DEFAULT ('') FOR [Rotation] ,
   CONSTRAINT [DF_Ad_Weight] DEFAULT (0) FOR [Weight]
GO

ALTER TABLE [dbo].[Ad] WITH NOCHECK ADD
   CONSTRAINT [PK_Ad] PRIMARY KEY NONCLUSTERED
   ([AdID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Ad_MemberID]
   ON [dbo].[Ad]
   ([CompanyID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO