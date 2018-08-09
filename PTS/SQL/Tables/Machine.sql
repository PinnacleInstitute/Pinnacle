EXEC [dbo].pts_CheckTable 'Machine'
 GO

CREATE TABLE [dbo].[Machine] (
   [MachineID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [LiveDriveID] int NOT NULL ,
   [NameLast] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Password] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [WebName] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Service] int NOT NULL ,
   [ActiveDate] datetime NOT NULL ,
   [CancelDate] datetime NOT NULL ,
   [RemoveDate] datetime NOT NULL ,
   [BackupUsed] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [BackupCapacity] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [BriefcaseUsed] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [BriefcaseCapacity] nvarchar (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Qty] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Machine] WITH NOCHECK ADD
   CONSTRAINT [DF_Machine_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Machine_LiveDriveID] DEFAULT (0) FOR [LiveDriveID] ,
   CONSTRAINT [DF_Machine_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Machine_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Machine_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Machine_Password] DEFAULT ('') FOR [Password] ,
   CONSTRAINT [DF_Machine_WebName] DEFAULT ('') FOR [WebName] ,
   CONSTRAINT [DF_Machine_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Machine_Service] DEFAULT (0) FOR [Service] ,
   CONSTRAINT [DF_Machine_ActiveDate] DEFAULT (0) FOR [ActiveDate] ,
   CONSTRAINT [DF_Machine_CancelDate] DEFAULT (0) FOR [CancelDate] ,
   CONSTRAINT [DF_Machine_RemoveDate] DEFAULT (0) FOR [RemoveDate] ,
   CONSTRAINT [DF_Machine_BackupUsed] DEFAULT ('') FOR [BackupUsed] ,
   CONSTRAINT [DF_Machine_BackupCapacity] DEFAULT ('') FOR [BackupCapacity] ,
   CONSTRAINT [DF_Machine_BriefcaseUsed] DEFAULT ('') FOR [BriefcaseUsed] ,
   CONSTRAINT [DF_Machine_BriefcaseCapacity] DEFAULT ('') FOR [BriefcaseCapacity] ,
   CONSTRAINT [DF_Machine_Qty] DEFAULT (0) FOR [Qty]
GO

ALTER TABLE [dbo].[Machine] WITH NOCHECK ADD
   CONSTRAINT [PK_Machine] PRIMARY KEY NONCLUSTERED
   ([MachineID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Machine_Email]
   ON [dbo].[Machine]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Machine_WebName]
   ON [dbo].[Machine]
   ([WebName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Machine_MachineName]
   ON [dbo].[Machine]
   ([NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO