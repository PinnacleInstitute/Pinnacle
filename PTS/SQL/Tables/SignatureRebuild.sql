EXEC [dbo].pts_CheckTableRebuild 'Signature'
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