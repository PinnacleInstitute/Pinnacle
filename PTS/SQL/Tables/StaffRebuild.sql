EXEC [dbo].pts_CheckTableRebuild 'Staff'
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