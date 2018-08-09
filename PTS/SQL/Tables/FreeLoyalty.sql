EXEC [dbo].pts_CheckTable 'FreeLoyalty'
 GO

CREATE TABLE [dbo].[FreeLoyalty] (
   [FreeLoyaltyID] int IDENTITY (1,1) NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[FreeLoyalty] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[FreeLoyalty] WITH NOCHECK ADD
   CONSTRAINT [PK_FreeLoyalty] PRIMARY KEY NONCLUSTERED
   ([FreeLoyaltyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO