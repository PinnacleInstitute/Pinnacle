EXEC [dbo].pts_CheckTable 'Govid'
 GO

CREATE TABLE [dbo].[Govid] (
   [GovidID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [GType] int NOT NULL ,
   [GNumber] nvarchar (50) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Issuer] varchar (2) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IssueDate] datetime NOT NULL ,
   [ExpDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Govid] WITH NOCHECK ADD
   CONSTRAINT [DF_Govid_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Govid_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Govid_GType] DEFAULT (0) FOR [GType] ,
   CONSTRAINT [DF_Govid_GNumber] DEFAULT ('') FOR [GNumber] ,
   CONSTRAINT [DF_Govid_Issuer] DEFAULT ('') FOR [Issuer] ,
   CONSTRAINT [DF_Govid_IssueDate] DEFAULT (0) FOR [IssueDate] ,
   CONSTRAINT [DF_Govid_ExpDate] DEFAULT (0) FOR [ExpDate]
GO

ALTER TABLE [dbo].[Govid] WITH NOCHECK ADD
   CONSTRAINT [PK_Govid] PRIMARY KEY NONCLUSTERED
   ([GovidID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Govid_Member]
   ON [dbo].[Govid]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO