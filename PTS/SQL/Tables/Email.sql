EXEC [dbo].pts_CheckTable 'Email'
 GO

CREATE TABLE [dbo].[Email] (
   [EmailID] int IDENTITY (1,1) NOT NULL ,
   [CompanyID] int NOT NULL ,
   [NewsLetterID] int NOT NULL ,
   [EmailListID] int NOT NULL ,
   [EmailName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FromEmail] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Subject] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [FileName] nvarchar (20) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [SendDate] datetime NOT NULL ,
   [Repeat] nvarchar (5) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EndDate] datetime NOT NULL ,
   [Mailings] int NOT NULL ,
   [Emails] int NOT NULL ,
   [TestEmail] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestFirstName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestLastName] nvarchar (30) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData1] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData2] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData3] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData4] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [TestData5] nvarchar (80) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [EmailType] int NOT NULL ,
   [IsSalesStep] bit NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Email] WITH NOCHECK ADD
   CONSTRAINT [DF_Email_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Email_NewsLetterID] DEFAULT (0) FOR [NewsLetterID] ,
   CONSTRAINT [DF_Email_EmailListID] DEFAULT (0) FOR [EmailListID] ,
   CONSTRAINT [DF_Email_EmailName] DEFAULT ('') FOR [EmailName] ,
   CONSTRAINT [DF_Email_FromEmail] DEFAULT ('') FOR [FromEmail] ,
   CONSTRAINT [DF_Email_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Email_FileName] DEFAULT ('') FOR [FileName] ,
   CONSTRAINT [DF_Email_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Email_SendDate] DEFAULT (0) FOR [SendDate] ,
   CONSTRAINT [DF_Email_Repeat] DEFAULT ('') FOR [Repeat] ,
   CONSTRAINT [DF_Email_EndDate] DEFAULT (0) FOR [EndDate] ,
   CONSTRAINT [DF_Email_Mailings] DEFAULT (0) FOR [Mailings] ,
   CONSTRAINT [DF_Email_Emails] DEFAULT (0) FOR [Emails] ,
   CONSTRAINT [DF_Email_TestEmail] DEFAULT ('') FOR [TestEmail] ,
   CONSTRAINT [DF_Email_TestFirstName] DEFAULT ('') FOR [TestFirstName] ,
   CONSTRAINT [DF_Email_TestLastName] DEFAULT ('') FOR [TestLastName] ,
   CONSTRAINT [DF_Email_TestData1] DEFAULT ('') FOR [TestData1] ,
   CONSTRAINT [DF_Email_TestData2] DEFAULT ('') FOR [TestData2] ,
   CONSTRAINT [DF_Email_TestData3] DEFAULT ('') FOR [TestData3] ,
   CONSTRAINT [DF_Email_TestData4] DEFAULT ('') FOR [TestData4] ,
   CONSTRAINT [DF_Email_TestData5] DEFAULT ('') FOR [TestData5] ,
   CONSTRAINT [DF_Email_EmailType] DEFAULT (0) FOR [EmailType] ,
   CONSTRAINT [DF_Email_IsSalesStep] DEFAULT (0) FOR [IsSalesStep]
GO

ALTER TABLE [dbo].[Email] WITH NOCHECK ADD
   CONSTRAINT [PK_Email] PRIMARY KEY NONCLUSTERED
   ([EmailID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Email_CompanyID]
   ON [dbo].[Email]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Email_NewLetterID]
   ON [dbo].[Email]
   ([NewsLetterID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO