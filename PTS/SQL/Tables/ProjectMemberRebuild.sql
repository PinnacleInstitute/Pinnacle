EXEC [dbo].pts_CheckTableRebuild 'ProjectMember'
 GO

ALTER TABLE [dbo].[ProjectMember] WITH NOCHECK ADD
   CONSTRAINT [DF_ProjectMember_ProjectID] DEFAULT (0) FOR [ProjectID] ,
   CONSTRAINT [DF_ProjectMember_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_ProjectMember_Status] DEFAULT (0) FOR [Status]
GO

ALTER TABLE [dbo].[ProjectMember] WITH NOCHECK ADD
   CONSTRAINT [PK_ProjectMember] PRIMARY KEY NONCLUSTERED
   ([ProjectMemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProjectMember_ProjectMember]
   ON [dbo].[ProjectMember]
   ([ProjectID], [MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_ProjectMember_MemberID]
   ON [dbo].[ProjectMember]
   ([MemberID], [ProjectID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO