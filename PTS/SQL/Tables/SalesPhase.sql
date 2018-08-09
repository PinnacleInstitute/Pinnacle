EXEC [dbo].pts_CheckTable 'SalesPhase'
 GO

CREATE TABLE [dbo].[SalesPhase] (
   [SalesPhaseID] int IDENTITY (1,1) NOT NULL ,
   [NextPhaseID] int NOT NULL ,
   [SalesPhaseName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Subject] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FileName] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [SendDate] datetime NOT NULL ,
   [Repeat] nvarchar (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [Mailings] int NOT NULL ,
   [SalesPhases] int NOT NULL ,
   [TestSalesPhase] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestFirstName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestLastName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData1] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData2] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData3] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Sequence] int NOT NULL ,
   [EmailType] int NOT NULL ,
   [Delay] datetime NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesPhase] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesPhase_NextPhaseID] DEFAULT (0) FOR [NextPhaseID] ,
   CONSTRAINT [DF_SalesPhase_SalesPhaseName] DEFAULT ('') FOR [SalesPhaseName] ,
   CONSTRAINT [DF_SalesPhase_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_SalesPhase_FileName] DEFAULT ('') FOR [FileName] ,
   CONSTRAINT [DF_SalesPhase_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_SalesPhase_SendDate] DEFAULT (0) FOR [SendDate] ,
   CONSTRAINT [DF_SalesPhase_Repeat] DEFAULT ('') FOR [Repeat] ,
   CONSTRAINT [DF_SalesPhase_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_SalesPhase_Mailings] DEFAULT (0) FOR [Mailings] ,
   CONSTRAINT [DF_SalesPhase_SalesPhases] DEFAULT (0) FOR [SalesPhases] ,
   CONSTRAINT [DF_SalesPhase_TestSalesPhase] DEFAULT ('') FOR [TestSalesPhase] ,
   CONSTRAINT [DF_SalesPhase_TestFirstName] DEFAULT ('') FOR [TestFirstName] ,
   CONSTRAINT [DF_SalesPhase_TestLastName] DEFAULT ('') FOR [TestLastName] ,
   CONSTRAINT [DF_SalesPhase_TestData1] DEFAULT ('') FOR [TestData1] ,
   CONSTRAINT [DF_SalesPhase_TestData2] DEFAULT ('') FOR [TestData2] ,
   CONSTRAINT [DF_SalesPhase_TestData3] DEFAULT ('') FOR [TestData3] ,
   CONSTRAINT [DF_SalesPhase_Sequence] DEFAULT (0) FOR [Sequence] ,
   CONSTRAINT [DF_SalesPhase_EmailType] DEFAULT (0) FOR [EmailType] ,
   CONSTRAINT [DF_SalesPhase_Delay] DEFAULT (0) FOR [Delay],
   CONSTRAINT [DF_SalesPhase_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_SalesPhase_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_SalesPhase_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_SalesPhase_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[SalesPhase] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesPhase] PRIMARY KEY NONCLUSTERED
   ([SalesPhaseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO