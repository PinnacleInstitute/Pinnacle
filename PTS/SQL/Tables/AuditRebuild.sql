EXEC [dbo].pts_CheckTableRebuild 'Audit'
 GO

ALTER TABLE [dbo].[Audit] WITH NOCHECK ADD
   CONSTRAINT [DF_Audit_AuthUserID] DEFAULT (0) FOR [AuthUserID] ,
   CONSTRAINT [DF_Audit_AuditDate] DEFAULT (0) FOR [AuditDate] ,
   CONSTRAINT [DF_Audit_Action] DEFAULT (0) FOR [Action] ,
   CONSTRAINT [DF_Audit_Page] DEFAULT ('') FOR [Page] ,
   CONSTRAINT [DF_Audit_IP] DEFAULT ('') FOR [IP]
GO

ALTER TABLE [dbo].[Audit] WITH NOCHECK ADD
   CONSTRAINT [PK_Audit] PRIMARY KEY NONCLUSTERED
   ([AuditID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Audit_AuditDate]
   ON [dbo].[Audit]
   ([AuditDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO