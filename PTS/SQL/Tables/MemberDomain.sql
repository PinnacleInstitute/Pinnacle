EXEC [dbo].pts_CheckTable 'MemberDomain'
 GO

CREATE TABLE [dbo].[MemberDomain] (
   [MemberDomainID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [DomainID] int NOT NULL ,
   [LeadCampaignID] int NOT NULL ,
   [PageType] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[MemberDomain] WITH NOCHECK ADD
   CONSTRAINT [DF_MemberDomain_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_MemberDomain_DomainID] DEFAULT (0) FOR [DomainID] ,
   CONSTRAINT [DF_MemberDomain_LeadCampaignID] DEFAULT (0) FOR [LeadCampaignID] ,
   CONSTRAINT [DF_MemberDomain_PageType] DEFAULT (0) FOR [PageType]
GO

ALTER TABLE [dbo].[MemberDomain] WITH NOCHECK ADD
   CONSTRAINT [PK_MemberDomain] PRIMARY KEY NONCLUSTERED
   ([MemberDomainID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_MemberDomain_MemberID]
   ON [dbo].[MemberDomain]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO