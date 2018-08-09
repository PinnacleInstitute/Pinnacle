EXEC [dbo].pts_CheckTableRebuild 'Address'
 GO

ALTER TABLE [dbo].[Address] WITH NOCHECK ADD
   CONSTRAINT [DF_Address_OwnerType] DEFAULT (0) FOR [OwnerType] ,
   CONSTRAINT [DF_Address_OwnerID] DEFAULT (0) FOR [OwnerID] ,
   CONSTRAINT [DF_Address_CountryID] DEFAULT (0) FOR [CountryID] ,
   CONSTRAINT [DF_Address_AddressType] DEFAULT (0) FOR [AddressType] ,
   CONSTRAINT [DF_Address_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_Address_Street1] DEFAULT ('') FOR [Street1] ,
   CONSTRAINT [DF_Address_Street2] DEFAULT ('') FOR [Street2] ,
   CONSTRAINT [DF_Address_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Address_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Address_Zip] DEFAULT ('') FOR [Zip]
GO

ALTER TABLE [dbo].[Address] WITH NOCHECK ADD
   CONSTRAINT [PK_Address] PRIMARY KEY NONCLUSTERED
   ([AddressID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Address_Owner]
   ON [dbo].[Address]
   ([OwnerType], [OwnerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO