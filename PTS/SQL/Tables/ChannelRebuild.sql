EXEC [dbo].pts_CheckTableRebuild 'Channel'
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