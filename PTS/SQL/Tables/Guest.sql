EXEC [dbo].pts_CheckTable 'Guest'
 GO

CREATE TABLE [dbo].[Guest] (
   [GuestID] int IDENTITY (1,1) NOT NULL ,
   [PartyID] int NOT NULL ,
   [NameLast] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [NameFirst] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Email] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [Attend] bit NOT NULL ,
   [Sale] money NOT NULL 
   ) ON [PRIMARY]
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