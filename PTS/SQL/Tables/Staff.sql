EXEC [dbo].pts_CheckTable 'Staff'
 GO

CREATE TABLE [dbo].[Staff] (
   [StaffID] int IDENTITY (1,1) NOT NULL ,
   [MerchantID] int NOT NULL ,
   [ConsumerID] int NOT NULL ,
   [StaffName] nvarchar (40) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Code] int NOT NULL ,
   [Status] int NOT NULL ,
   [StaffDate] datetime NOT NULL ,
   [Access] varchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Staff] WITH NOCHECK ADD
   CONSTRAINT [DF_Staff_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Staff_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_Staff_StaffName] DEFAULT ('') FOR [StaffName] ,
   CONSTRAINT [DF_Staff_Code] DEFAULT (0) FOR [Code] ,
   CONSTRAINT [DF_Staff_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Staff_StaffDate] DEFAULT (0) FOR [StaffDate] ,
   CONSTRAINT [DF_Staff_Access] DEFAULT ('') FOR [Access]
GO

ALTER TABLE [dbo].[Staff] WITH NOCHECK ADD
   CONSTRAINT [PK_Staff] PRIMARY KEY NONCLUSTERED
   ([StaffID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Staff_Code]
   ON [dbo].[Staff]
   ([MerchantID], [Code])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Staff_StaffName]
   ON [dbo].[Staff]
   ([MerchantID], [StaffName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO