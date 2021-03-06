EXEC [dbo].pts_CheckTable 'News'
 GO

CREATE TABLE [dbo].[News] (
   [NewsID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [NewsTopicID] int NOT NULL ,
   [Title] nvarchar (150) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [ActiveDate] datetime NOT NULL ,
   [Image] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Tags] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Seq] int NOT NULL ,
   [LeadMain] int NOT NULL ,
   [LeadTopic] int NOT NULL ,
   [IsBreaking] bit NOT NULL ,
   [IsBreaking2] bit NOT NULL ,
   [IsStrategic] bit NOT NULL ,
   [IsShare] bit NOT NULL ,
   [IsEditorial] bit NOT NULL ,
   [UserRole] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[News] WITH NOCHECK ADD
   CONSTRAINT [DF_News_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_News_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_News_NewsTopicID] DEFAULT (0) FOR [NewsTopicID] ,
   CONSTRAINT [DF_News_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_News_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_News_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_News_ActiveDate] DEFAULT (0) FOR [ActiveDate] ,
   CONSTRAINT [DF_News_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_News_Tags] DEFAULT ('') FOR [Tags] ,
   CONSTRAINT [DF_News_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_News_Seq] DEFAULT (0) FOR [Seq] ,
   CONSTRAINT [DF_News_LeadMain] DEFAULT (0) FOR [LeadMain] ,
   CONSTRAINT [DF_News_LeadTopic] DEFAULT (0) FOR [LeadTopic] ,
   CONSTRAINT [DF_News_IsBreaking] DEFAULT (0) FOR [IsBreaking] ,
   CONSTRAINT [DF_News_IsBreaking2] DEFAULT (0) FOR [IsBreaking2] ,
   CONSTRAINT [DF_News_IsStrategic] DEFAULT (0) FOR [IsStrategic] ,
   CONSTRAINT [DF_News_IsShare] DEFAULT (0) FOR [IsShare] ,
   CONSTRAINT [DF_News_IsEditorial] DEFAULT (0) FOR [IsEditorial] ,
   CONSTRAINT [DF_News_UserRole] DEFAULT (0) FOR [UserRole]
GO

ALTER TABLE [dbo].[News] WITH NOCHECK ADD
   CONSTRAINT [PK_News] PRIMARY KEY NONCLUSTERED
   ([NewsID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_News_NewsTopicID]
   ON [dbo].[News]
   ([CompanyID], [ActiveDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO