EXEC [dbo].pts_CheckTableRebuild 'FreeLoyalty'
 GO

ALTER TABLE [dbo].[FreeLoyalty] WITH NOCHECK ADD

GO

ALTER TABLE [dbo].[FreeLoyalty] WITH NOCHECK ADD
   CONSTRAINT [PK_FreeLoyalty] PRIMARY KEY NONCLUSTERED
   ([FreeLoyaltyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO