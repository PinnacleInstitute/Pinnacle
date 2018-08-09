EXEC [dbo].pts_CheckTableRebuild 'Assessment'
 GO

ALTER TABLE [dbo].[Assessment] WITH NOCHECK ADD
   CONSTRAINT [DF_Assessment_TrainerID] DEFAULT (0) FOR [TrainerID] ,
   CONSTRAINT [DF_Assessment_CompanyID] DEFAULT (0) FOR [CompanyID] ,
   CONSTRAINT [DF_Assessment_FirstQuestionCode] DEFAULT (0) FOR [FirstQuestionCode] ,
   CONSTRAINT [DF_Assessment_AssessmentName] DEFAULT ('') FOR [AssessmentName] ,
   CONSTRAINT [DF_Assessment_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Assessment_Courses] DEFAULT ('') FOR [Courses] ,
   CONSTRAINT [DF_Assessment_Assessments] DEFAULT ('') FOR [Assessments] ,
   CONSTRAINT [DF_Assessment_AssessDate] DEFAULT (0) FOR [AssessDate] ,
   CONSTRAINT [DF_Assessment_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Assessment_AssessmentType] DEFAULT (0) FOR [AssessmentType] ,
   CONSTRAINT [DF_Assessment_NewURL] DEFAULT ('') FOR [NewURL] ,
   CONSTRAINT [DF_Assessment_EditURL] DEFAULT ('') FOR [EditURL] ,
   CONSTRAINT [DF_Assessment_ResultType] DEFAULT (0) FOR [ResultType] ,
   CONSTRAINT [DF_Assessment_Formula] DEFAULT ('') FOR [Formula] ,
   CONSTRAINT [DF_Assessment_CustomCode] DEFAULT (0) FOR [CustomCode] ,
   CONSTRAINT [DF_Assessment_Takes] DEFAULT (0) FOR [Takes] ,
   CONSTRAINT [DF_Assessment_Delay] DEFAULT (0) FOR [Delay] ,
   CONSTRAINT [DF_Assessment_IsTrial] DEFAULT (0) FOR [IsTrial] ,
   CONSTRAINT [DF_Assessment_IsPaid] DEFAULT (0) FOR [IsPaid] ,
   CONSTRAINT [DF_Assessment_IsCertify] DEFAULT (0) FOR [IsCertify] ,
   CONSTRAINT [DF_Assessment_AssessType] DEFAULT (0) FOR [AssessType] ,
   CONSTRAINT [DF_Assessment_AssessLevel] DEFAULT (0) FOR [AssessLevel] ,
   CONSTRAINT [DF_Assessment_AssessLength] DEFAULT (0) FOR [AssessLength] ,
   CONSTRAINT [DF_Assessment_ScoreFactor] DEFAULT (0) FOR [ScoreFactor] ,
   CONSTRAINT [DF_Assessment_Rating] DEFAULT (0) FOR [Rating] ,
   CONSTRAINT [DF_Assessment_Grade] DEFAULT (0) FOR [Grade] ,
   CONSTRAINT [DF_Assessment_Points] DEFAULT (0) FOR [Points] ,
   CONSTRAINT [DF_Assessment_TimeLimit] DEFAULT (0) FOR [TimeLimit] ,
   CONSTRAINT [DF_Assessment_NoCertificate] DEFAULT (0) FOR [NoCertificate] ,
   CONSTRAINT [DF_Assessment_IsCustomCertificate] DEFAULT (0) FOR [IsCustomCertificate]
GO

ALTER TABLE [dbo].[Assessment] WITH NOCHECK ADD
   CONSTRAINT [PK_Assessment] PRIMARY KEY NONCLUSTERED
   ([AssessmentID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Assessment_CompanyID]
   ON [dbo].[Assessment]
   ([CompanyID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Assessment_TrainerID]
   ON [dbo].[Assessment]
   ([TrainerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO