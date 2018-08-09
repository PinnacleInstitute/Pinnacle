EXEC [dbo].pts_CheckTable 'TaxRate'
 GO

CREATE TABLE [dbo].[TaxRate] (
   [TaxRateID] int IDENTITY (1,1) NOT NULL ,
   [Year] int NOT NULL ,
   [TaxType] int NOT NULL ,
   [Rate] money NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[TaxRate] WITH NOCHECK ADD
   CONSTRAINT [DF_TaxRate_Year] DEFAULT (0) FOR [Year] ,
   CONSTRAINT [DF_TaxRate_TaxType] DEFAULT (0) FOR [TaxType] ,
   CONSTRAINT [DF_TaxRate_Rate] DEFAULT (0) FOR [Rate]
GO

ALTER TABLE [dbo].[TaxRate] WITH NOCHECK ADD
   CONSTRAINT [PK_TaxRate] PRIMARY KEY NONCLUSTERED
   ([TaxRateID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_TaxRate_Year]
   ON [dbo].[TaxRate]
   ([Year], [TaxType])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO