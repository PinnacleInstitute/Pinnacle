EXEC [dbo].pts_CheckTable 'OrgMember'
 GO

CREATE TABLE [dbo].[OrgMember] (
   [OrgMemberID] int IDENTITY (1,1) NOT NULL ,
   [MemberID] int NOT NULL ,
   [OrgID] int NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[OrgMember] WITH NOCHECK ADD
   CONSTRAINT [DF_OrgMember_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_OrgMember_OrgID] DEFAULT (0) FOR [OrgID] 
GO

ALTER TABLE [dbo].[OrgMember] WITH NOCHECK ADD
   CONSTRAINT [PK_OrgMember] PRIMARY KEY NONCLUSTERED
   ([OrgMemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_OrgMember_OrgID]
   ON [dbo].[OrgMember]
   ([OrgID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_OrgMember_MemberID]
   ON [dbo].[OrgMember]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO