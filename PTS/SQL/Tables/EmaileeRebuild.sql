EXEC [dbo].pts_CheckTableRebuild 'Emailee'
 GO

ALTER TABLE [dbo].[Emailee] WITH NOCHECK ADD
   CONSTRAINT [DF_Emailee_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Emailee_EmailListID] DEFAULT (0) FOR [EmailListID] ,
   CONSTRAINT [DF_Emailee_Email] DEFAULT ('') FOR [Email] ,
   CONSTRAINT [DF_Emailee_FirstName] DEFAULT ('') FOR [FirstName] ,
   CONSTRAINT [DF_Emailee_LastName] DEFAULT ('') FOR [LastName] ,
   CONSTRAINT [DF_Emailee_Data1] DEFAULT ('') FOR [Data1] ,
   CONSTRAINT [DF_Emailee_Data2] DEFAULT ('') FOR [Data2] ,
   CONSTRAINT [DF_Emailee_Data3] DEFAULT ('') FOR [Data3] ,
   CONSTRAINT [DF_Emailee_Data4] DEFAULT ('') FOR [Data4] ,
   CONSTRAINT [DF_Emailee_Data5] DEFAULT ('') FOR [Data5] ,
   CONSTRAINT [DF_Emailee_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[Emailee] WITH NOCHECK ADD
   CONSTRAINT [PK_Emailee] PRIMARY KEY NONCLUSTERED
   ([EmaileeID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Emailee_CompanyID]
   ON [dbo].[Emailee]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Emailee_EmailListID]
   ON [dbo].[Emailee]
   ([EmailListID], [LastName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO