EXEC [dbo].pts_CheckTableRebuild 'Guest'
 GO

ALTER TABLE [dbo].[Guest] WITH NOCHECK ADD
   CONSTRAINT [DF_Guest_PartyID] DEFAULT (0) FOR [PartyID] ,
   CONSTRAINT [DF_Guest_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Guest_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Guest_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Guest_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Guest_Attend] DEFAULT (0) FOR [Attend] ,
   CONSTRAINT [DF_Guest_Sale] DEFAULT (0) FOR [Sale]
GO

ALTER TABLE [dbo].[Guest] WITH NOCHECK ADD
   CONSTRAINT [PK_Guest] PRIMARY KEY NONCLUSTERED
   ([GuestID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Guest_PartyID]
   ON [dbo].[Guest]
   ([PartyID], [NameLast], [NameFirst])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Guest_Email]
   ON [dbo].[Guest]
   ([Email])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO