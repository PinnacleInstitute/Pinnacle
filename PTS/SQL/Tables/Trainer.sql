EXEC [dbo].pts_CheckTable 'Trainer'
 GO

CREATE TABLE [dbo].[Trainer] (
   [TrainerID] int IDENTITY (1,1) NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [SponsorID] int NOT NULL ,
   [CompanyName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Unit] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Country] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone1] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Phone2] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Fax] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Tier] int NOT NULL ,
   [Website] varchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [URL] varchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Image] varchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EnrollDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Trainer] WITH NOCHECK ADD
   CONSTRAINT [DF_Trainer_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Trainer_SponsorID] DEFAULT (0) FOR [SponsorID] ,
   CONSTRAINT [DF_Trainer_CompanyName] DEFAULT ('') FOR [CompanyName] ,
   CONSTRAINT [DF_Trainer_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Trainer_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Trainer_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Trainer_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Trainer_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Trainer_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Trainer_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Trainer_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Trainer_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Trainer_Phone1] DEFAULT ('') FOR [Phone1] ,
   CONSTRAINT [DF_Trainer_Phone2] DEFAULT ('') FOR [Phone2] ,
   CONSTRAINT [DF_Trainer_Fax] DEFAULT ('') FOR [Fax] ,
   CONSTRAINT [DF_Trainer_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Trainer_Tier] DEFAULT (0) FOR [Tier] ,
   CONSTRAINT [DF_Trainer_Website] DEFAULT ('') FOR [Website] ,
   CONSTRAINT [DF_Trainer_URL] DEFAULT ('') FOR [URL] ,
   CONSTRAINT [DF_Trainer_Image] DEFAULT ('') FOR [Image] ,
   CONSTRAINT [DF_Trainer_EnrollDate] DEFAULT (0) FOR [EnrollDate]
GO

ALTER TABLE [dbo].[Trainer] WITH NOCHECK ADD
   CONSTRAINT [PK_Trainer] PRIMARY KEY NONCLUSTERED
   ([TrainerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Trainer_AuthUserID]
   ON [dbo].[Trainer]
   ([AuthUserID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO