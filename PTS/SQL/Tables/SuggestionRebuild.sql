EXEC [dbo].pts_CheckTableRebuild 'Suggestion'
 GO

ALTER TABLE [dbo].[Suggestion] WITH NOCHECK ADD
   CONSTRAINT [DF_Suggestion_OrgID] DEFAULT (0) FOR [OrgID] ,
   CONSTRAINT [DF_Suggestion_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Suggestion_Subject] DEFAULT ('') FOR [Subject] ,
   CONSTRAINT [DF_Suggestion_Description] DEFAULT ('') FOR [Description] ,
   CONSTRAINT [DF_Suggestion_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Suggestion_SuggestionDate] DEFAULT (0) FOR [SuggestionDate] ,
   CONSTRAINT [DF_Suggestion_Response] DEFAULT ('') FOR [Response] ,
   CONSTRAINT [DF_Suggestion_ChangeDate] DEFAULT (0) FOR [ChangeDate]
GO

ALTER TABLE [dbo].[Suggestion] WITH NOCHECK ADD
   CONSTRAINT [PK_Suggestion] PRIMARY KEY NONCLUSTERED
   ([SuggestionID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Suggestion_OrgID]
   ON [dbo].[Suggestion]
   ([OrgID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Suggestion_MemberID]
   ON [dbo].[Suggestion]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO