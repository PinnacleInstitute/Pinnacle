EXEC [dbo].pts_CheckTable 'MemberSales'
 GO

CREATE TABLE [dbo].[MemberSales] (
   [MemberSalesID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [CompanyID] int NOT NULL ,
   [SalesDate] datetime NOT NULL ,
   [Title] int NOT NULL ,
   [PV] money NOT NULL ,
   [GV] money NOT NULL ,
   [PV2] money NOT NULL ,
   [GV2] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MemberSales] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberSales_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberSales_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_MemberSales_SalesDate] DEFAULT (0) FOR [SalesDate] ,
   CONSTRAINT [DF_MemberSales_Title] DEFAULT (0) FOR [Title] ,
   CONSTRAINT [DF_MemberSales_PV] DEFAULT (0) FOR [PV] ,
   CONSTRAINT [DF_MemberSales_GV] DEFAULT (0) FOR [GV] ,
   CONSTRAINT [DF_MemberSales_PV2] DEFAULT (0) FOR [PV2] ,
   CONSTRAINT [DF_MemberSales_GV2] DEFAULT (0) FOR [GV2]
GO

ALTER TABLE [dbo].[MemberSales] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberSales] PRIMARY KEY NONCLUSTERED
   ([MemberSalesID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberSales_MemberID]
   ON [dbo].[MemberSales]
   ([MemberID], [SalesDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO