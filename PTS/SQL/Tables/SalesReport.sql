EXEC [dbo].pts_CheckTable 'SalesReport'
 GO

CREATE TABLE [dbo].[SalesReport] (
   [SalesReportID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [ReportDate] datetime NOT NULL ,
   [Level] int NOT NULL ,
   [PV] money NOT NULL ,
   [GV] money NOT NULL ,
   [CreateDate] datetime NOT NULL ,
   [CreateID] int NOT NULL ,
   [ChangeDate] datetime NOT NULL ,
   [ChangeID] int NOT NULL
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[SalesReport] WITH NOCHECK ADD
   CONSTRAINT [DF_SalesReport_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_SalesReport_ReportDate] DEFAULT (0) FOR [ReportDate] ,
   CONSTRAINT [DF_SalesReport_Level] DEFAULT (0) FOR [Level] ,
   CONSTRAINT [DF_SalesReport_PV] DEFAULT (0) FOR [PV] ,
   CONSTRAINT [DF_SalesReport_GV] DEFAULT (0) FOR [GV],
   CONSTRAINT [DF_SalesReport_CreateDate] DEFAULT (0) FOR [CreateDate] ,
   CONSTRAINT [DF_SalesReport_CreateID] DEFAULT (0) FOR [CreateID] ,
   CONSTRAINT [DF_SalesReport_ChangeDate] DEFAULT (0) FOR [ChangeDate] ,
   CONSTRAINT [DF_SalesReport_ChangeID] DEFAULT (0) FOR [ChangeID]
GO

ALTER TABLE [dbo].[SalesReport] WITH NOCHECK ADD
   CONSTRAINT [PK_SalesReport] PRIMARY KEY NONCLUSTERED
   ([SalesReportID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_SalesReport_MemberDate]
   ON [dbo].[SalesReport]
   ([MemberID], [ReportDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO