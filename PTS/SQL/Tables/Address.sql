EXEC [dbo].pts_CheckTable 'Address'
 GO

CREATE TABLE [dbo].[Address] (
   [AddressID] int IDENTITY (1,1) NOT NULL ,
   [OwnerType] int NOT NULL ,
   [OwnerID] int NOT NULL ,
   [CountryID] int NOT NULL ,
   [AddressType] int NOT NULL ,
   [IsActive] bit NOT NULL ,
   [Street1] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Street2] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [City] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [State] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Zip] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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