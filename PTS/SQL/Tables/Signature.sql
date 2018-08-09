EXEC [dbo].pts_CheckTable 'Signature'
 GO

CREATE TABLE [dbo].[Signature] (
   [SignatureID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [UseType] int NOT NULL ,
   [UseID] int NOT NULL ,
   [IsActive] bit NOT NULL ,
   [Data] nvarchar (4000) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Language] varchar (6) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Signature] WITH NOCHECK ADD
   CONSTRAINT [DF_Signature_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Signature_UseType] DEFAULT (0) FOR [UseType] ,
   CONSTRAINT [DF_Signature_UseID] DEFAULT (0) FOR [UseID] ,
   CONSTRAINT [DF_Signature_IsActive] DEFAULT (0) FOR [IsActive] ,
   CONSTRAINT [DF_Signature_Data] DEFAULT ('') FOR [Data] ,
   CONSTRAINT [DF_Signature_Language] DEFAULT ('') FOR [Language]
GO

ALTER TABLE [dbo].[Signature] WITH NOCHECK ADD
   CONSTRAINT [PK_Signature] PRIMARY KEY NONCLUSTERED
   ([SignatureID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Signature_MemberID]
   ON [dbo].[Signature]
   ([MemberID], [UseType], [UseID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO