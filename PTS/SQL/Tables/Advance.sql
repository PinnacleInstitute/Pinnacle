EXEC [dbo].pts_CheckTable 'Advance'
 GO

CREATE TABLE [dbo].[Advance] (
   [AdvanceID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [Personal] int NOT NULL ,
   [Group] int NOT NULL ,
   [Title] int NOT NULL ,
   [IsLocked] bit NOT NULL ,
   [Title1] int NOT NULL ,
   [Title2] int NOT NULL ,
   [Title3] int NOT NULL ,
   [Title4] int NOT NULL ,
   [Title5] int NOT NULL ,
   [Process] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Advance] WITH NOCHECK ADD
   CONSTRAINT [DF_Advance_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Advance_Personal] DEFAULT (0) FOR [Personal] ,
   CONSTRAINT [DF_Advance_Group] DEFAULT (0) FOR [Group] ,
   CONSTRAINT [DF_Advance_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_Advance_IsLocked] DEFAULT (0) FOR [IsLocked] ,
   CONSTRAINT [DF_Advance_Title1] DEFAULT (0) FOR [Title1] ,
   CONSTRAINT [DF_Advance_Title2] DEFAULT (0) FOR [Title2] ,
   CONSTRAINT [DF_Advance_Title3] DEFAULT (0) FOR [Title3] ,
   CONSTRAINT [DF_Advance_Title4] DEFAULT (0) FOR [Title4] ,
   CONSTRAINT [DF_Advance_Title5] DEFAULT (0) FOR [Title5] ,
   CONSTRAINT [DF_Advance_Process] DEFAULT (0) FOR [Process]
GO

ALTER TABLE [dbo].[Advance] WITH NOCHECK ADD
   CONSTRAINT [PK_Advance] PRIMARY KEY NONCLUSTERED
   ([AdvanceID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Advance_MemberID]
   ON [dbo].[Advance]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO