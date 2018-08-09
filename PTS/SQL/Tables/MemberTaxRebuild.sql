EXEC [dbo].pts_CheckTableRebuild 'MemberTax'
 GO

ALTER TABLE [dbo].[MemberTax] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberTax_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberTax_Year] DEFAULT (0) FOR [Year] ,
   CONSTRAINT [DF_MemberTax_VehicleMethod] DEFAULT (0) FOR [VehicleMethod] ,
   CONSTRAINT [DF_MemberTax_MilesStart] DEFAULT (0) FOR [MilesStart] ,
   CONSTRAINT [DF_MemberTax_MilesEnd] DEFAULT (0) FOR [MilesEnd] ,
   CONSTRAINT [DF_MemberTax_TotalMiles] DEFAULT (0) FOR [TotalMiles] ,
   CONSTRAINT [DF_MemberTax_BusMiles] DEFAULT (0) FOR [BusMiles] ,
   CONSTRAINT [DF_MemberTax_VehicleRate] DEFAULT (0) FOR [VehicleRate] ,
   CONSTRAINT [DF_MemberTax_TotalSpace] DEFAULT (0) FOR [TotalSpace] ,
   CONSTRAINT [DF_MemberTax_BusSpace] DEFAULT (0) FOR [BusSpace] ,
   CONSTRAINT [DF_MemberTax_SpaceRate] DEFAULT (0) FOR [SpaceRate] ,
   CONSTRAINT [DF_MemberTax_Notes] DEFAULT ('') FOR [Notes]
GO

ALTER TABLE [dbo].[MemberTax] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberTax] PRIMARY KEY NONCLUSTERED
   ([MemberTaxID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberTax_Member]
   ON [dbo].[MemberTax]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO