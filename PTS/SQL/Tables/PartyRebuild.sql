EXEC [dbo].pts_CheckTableRebuild 'Party'
 GO

ALTER TABLE [dbo].[Party] WITH NOCHECK ADD
   CONSTRAINT [DF_Party_ApptID] DEFAULT (0) FOR [ApptID] ,
   CONSTRAINT [DF_Party_NameLast] DEFAULT ('') FOR [NameLast] ,
   CONSTRAINT [DF_Party_NameFirst] DEFAULT ('') FOR [NameFirst] ,
   CONSTRAINT [DF_Party_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Party_IsTrained] DEFAULT (0) FOR [IsTrained] ,
   CONSTRAINT [DF_Party_Phone] DEFAULT ('') FOR [Phone] ,
   CONSTRAINT [DF_Party_Location] DEFAULT ('') FOR [Location] ,
   CONSTRAINT [DF_Party_Street] DEFAULT ('') FOR [Street] ,
   CONSTRAINT [DF_Party_Unit] DEFAULT ('') FOR [Unit] ,
   CONSTRAINT [DF_Party_City] DEFAULT ('') FOR [City] ,
   CONSTRAINT [DF_Party_State] DEFAULT ('') FOR [State] ,
   CONSTRAINT [DF_Party_Zip] DEFAULT ('') FOR [Zip] ,
   CONSTRAINT [DF_Party_Country] DEFAULT ('') FOR [Country] ,
   CONSTRAINT [DF_Party_IsMap] DEFAULT (0) FOR [IsMap] ,
   CONSTRAINT [DF_Party_Message] DEFAULT ('') FOR [Message] ,
   CONSTRAINT [DF_Party_Theme] DEFAULT (0) FOR [Theme] ,
   CONSTRAINT [DF_Party_CustomTheme] DEFAULT (0) FOR [CustomTheme] ,
   CONSTRAINT [DF_Party_Sales] DEFAULT (0) FOR [Sales] ,
   CONSTRAINT [DF_Party_IsShop] DEFAULT (0) FOR [IsShop]
GO

ALTER TABLE [dbo].[Party] WITH NOCHECK ADD
   CONSTRAINT [PK_Party] PRIMARY KEY NONCLUSTERED
   ([PartyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Party_ApptID]
   ON [dbo].[Party]
   ([ApptID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO