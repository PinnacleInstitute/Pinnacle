EXEC [dbo].pts_CheckTable 'Block'
 GO

CREATE TABLE [dbo].[Block] (
   [BlockID] int IDENTITY (1,1) NOT NULL ,
   [ConsumerID] int NOT NULL ,
   [MerchantID] int NOT NULL ,
   [BlockDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Block] WITH NOCHECK ADD
   CONSTRAINT [DF_Block_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_Block_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Block_BlockDate] DEFAULT (0) FOR [BlockDate]
GO

ALTER TABLE [dbo].[Block] WITH NOCHECK ADD
   CONSTRAINT [PK_Block] PRIMARY KEY NONCLUSTERED
   ([BlockID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Block_MerchantID]
   ON [dbo].[Block]
   ([MerchantID], [BlockDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Block_ConsumerID]
   ON [dbo].[Block]
   ([ConsumerID], [MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO