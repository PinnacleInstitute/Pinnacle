EXEC [dbo].pts_CheckTableRebuild 'Survey'
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