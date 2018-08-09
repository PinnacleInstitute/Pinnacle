EXEC [dbo].pts_CheckTable 'Channel'
 GO

CREATE TABLE [dbo].[Channel] (
   [ChannelID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [PubDate] datetime NOT NULL ,
   [Title] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Link] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IsActive] bit NOT NULL ,
   [Filename] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Image] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Language] nvarchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Channel] WITH NOCHECK ADD
   CONSTRAINT [DF_Channel_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Channel_PubDate] DEFAULT (0) FOR [PubDate] ,
   CONSTRAINT [DF_Channel_Title] DEFAULT ('') FOR [Title] ,
   CONSTRAINT [DF_Channel_Link] DEFAULT ('') FOR [Link] ,
   CONSTRAINT [DF_Channel_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Channel_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_Channel_Filename] DEFAULT ('') FOR [Filename] ,
   CONSTRAINT [DF_Channel_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_Channel_Language] DEFAULT ('') FOR [Language]
GO

ALTER TABLE [dbo].[Channel] WITH NOCHECK ADD
   CONSTRAINT [PK_Channel] PRIMARY KEY NONCLUSTERED
   ([ChannelID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Channel_CompanyID]
   ON [dbo].[Channel]
   ([CompanyID], [PubDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO