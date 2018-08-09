EXEC [dbo].pts_CheckTableRebuild 'Machine'
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