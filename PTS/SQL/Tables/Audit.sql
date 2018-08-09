EXEC [dbo].pts_CheckTable 'Audit'
 GO

CREATE TABLE [dbo].[Audit] (
   [AuditID] int IDENTITY (1,1) NOT NULL ,
   [AuthUserID] int NOT NULL ,
   [AuditDate] datetime NOT NULL ,
   [Action] int NOT NULL ,
   [Page] varchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [IP] varchar (16) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
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