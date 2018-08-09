EXEC [dbo].pts_CheckTableRebuild 'Domain'
 GO

ALTER TABLE [dbo].[Domain] WITH NOCHECK ADD
   CONSTRAINT [DF_Domain_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Domain_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Domain_DomainName] DEFAULT ('') FOR [DomainName]
GO

ALTER TABLE [dbo].[Domain] WITH NOCHECK ADD
   CONSTRAINT [PK_Domain] PRIMARY KEY NONCLUSTERED
   ([DomainID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Domain_CompanyID]
   ON [dbo].[Domain]
   ([CompanyID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Domain_DomainName]
   ON [dbo].[Domain]
   ([DomainName])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO