EXEC [dbo].pts_CheckTable 'Emailee'
 GO

CREATE TABLE [dbo].[Emailee] (
   [EmaileeID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [EmailListID] int NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FirstName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [LastName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Data1] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Data2] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Data3] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Data4] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Data5] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Emailee] WITH NOCHECK ADD
   CONSTRAINT [DF_Emailee_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Emailee_EmailListID] DEFAULT (0) FOR [EmailListID] ,
   CONSTRAINT [DF_Emailee_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Emailee_FirstName] DEFAULT ('') FOR [FirstName] ,
   CONSTRAINT [DF_Emailee_LastName] DEFAULT ('') FOR [LastName] ,
   CONSTRAINT [DF_Emailee_Data1] DEFAULT ('') FOR [Data1] ,
   CONSTRAINT [DF_Emailee_Data2] DEFAULT ('') FOR [Data2] ,
   CONSTRAINT [DF_Emailee_Data3] DEFAULT ('') FOR [Data3] ,
   CONSTRAINT [DF_Emailee_Data4] DEFAULT ('') FOR [Data4] ,
   CONSTRAINT [DF_Emailee_Data5] DEFAULT ('') FOR [Data5] ,
   CONSTRAINT [DF_Emailee_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[Emailee] WITH NOCHECK ADD
   CONSTRAINT [PK_Emailee] PRIMARY KEY NONCLUSTERED
   ([EmaileeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Emailee_CompanyID]
   ON [dbo].[Emailee]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Emailee_EmailListID]
   ON [dbo].[Emailee]
   ([EmailListID], [LastName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO