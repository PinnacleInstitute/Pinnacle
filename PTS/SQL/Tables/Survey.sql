EXEC [dbo].pts_CheckTable 'Survey'
 GO

CREATE TABLE [dbo].[Survey] (
   [SurveyID] int IDENTITY (1,1) NOT NULL ,
   [OrgID] int NOT NULL ,
   [SurveyName] nvarchar (60) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Description] nvarchar (500) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Status] int NOT NULL ,
   [StartDate] datetime NOT NULL ,
   [EndDate] datetime NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Survey] WITH NOCHECK ADD
   CONSTRAINT [DF_Survey_OrgID] DEFAULT (0) FOR [OrgID] ,
   CONSTRAINT [DF_Survey_SurveyName] DEFAULT ('') FOR [SurveyName] ,
   CONSTRAINT [DF_Survey_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Survey_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Survey_StartDate] DEFAULT (0) FOR [StartDate] ,
   CONSTRAINT [DF_Survey_EndDate] DEFAULT (0) FOR [EndDate]
GO

ALTER TABLE [dbo].[Survey] WITH NOCHECK ADD
   CONSTRAINT [PK_Survey] PRIMARY KEY NONCLUSTERED
   ([SurveyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Survey_OrgID]
   ON [dbo].[Survey]
   ([OrgID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO