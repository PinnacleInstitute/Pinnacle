EXEC [dbo].pts_CheckTableRebuild 'Profile'
 GO

ALTER TABLE [dbo].[Profile] WITH NOCHECK ADD
   CONSTRAINT [DF_Profile_MemberID] DEFAULT (0) FOR [MemberID] ,
   CONSTRAINT [DF_Profile_ProfileDate] DEFAULT (0) FOR [ProfileDate] ,
   CONSTRAINT [DF_Profile_ProfileType] DEFAULT (0) FOR [ProfileType] ,
   CONSTRAINT [DF_Profile_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Profile_VQResponse] DEFAULT ('') FOR [VQResponse] ,
   CONSTRAINT [DF_Profile_SQResponse] DEFAULT ('') FOR [SQResponse] ,
   CONSTRAINT [DF_Profile_VQDiff] DEFAULT (0) FOR [VQDiff] ,
   CONSTRAINT [DF_Profile_VQDimPerc] DEFAULT (0) FOR [VQDimPerc] ,
   CONSTRAINT [DF_Profile_VQDimPos_I] DEFAULT (0) FOR [VQDimPos_I] ,
   CONSTRAINT [DF_Profile_VQDimPos_E] DEFAULT (0) FOR [VQDimPos_E] ,
   CONSTRAINT [DF_Profile_VQDimPos_S] DEFAULT (0) FOR [VQDimPos_S] ,
   CONSTRAINT [DF_Profile_VQDimNeg_I] DEFAULT (0) FOR [VQDimNeg_I] ,
   CONSTRAINT [DF_Profile_VQDimNeg_E] DEFAULT (0) FOR [VQDimNeg_E] ,
   CONSTRAINT [DF_Profile_VQDimNeg_S] DEFAULT (0) FOR [VQDimNeg_S] ,
   CONSTRAINT [DF_Profile_VQIntCate_I] DEFAULT (0) FOR [VQIntCate_I] ,
   CONSTRAINT [DF_Profile_VQIntCate_E] DEFAULT (0) FOR [VQIntCate_E] ,
   CONSTRAINT [DF_Profile_VQIntCate_S] DEFAULT (0) FOR [VQIntCate_S] ,
   CONSTRAINT [DF_Profile_VQInt] DEFAULT (0) FOR [VQInt] ,
   CONSTRAINT [DF_Profile_VQIntPerc] DEFAULT (0) FOR [VQIntPerc] ,
   CONSTRAINT [DF_Profile_VQDI] DEFAULT (0) FOR [VQDI] ,
   CONSTRAINT [DF_Profile_VQDIS] DEFAULT (0) FOR [VQDIS] ,
   CONSTRAINT [DF_Profile_VQLeft] DEFAULT (0) FOR [VQLeft] ,
   CONSTRAINT [DF_Profile_VQRight] DEFAULT (0) FOR [VQRight] ,
   CONSTRAINT [DF_Profile_VQAI] DEFAULT (0) FOR [VQAI] ,
   CONSTRAINT [DF_Profile_SQDiff] DEFAULT (0) FOR [SQDiff] ,
   CONSTRAINT [DF_Profile_SQDimPerc] DEFAULT (0) FOR [SQDimPerc] ,
   CONSTRAINT [DF_Profile_SQDimPos_I] DEFAULT (0) FOR [SQDimPos_I] ,
   CONSTRAINT [DF_Profile_SQDimPos_E] DEFAULT (0) FOR [SQDimPos_E] ,
   CONSTRAINT [DF_Profile_SQDimPos_S] DEFAULT (0) FOR [SQDimPos_S] ,
   CONSTRAINT [DF_Profile_SQDimNeg_I] DEFAULT (0) FOR [SQDimNeg_I] ,
   CONSTRAINT [DF_Profile_SQDimNeg_E] DEFAULT (0) FOR [SQDimNeg_E] ,
   CONSTRAINT [DF_Profile_SQDimNeg_S] DEFAULT (0) FOR [SQDimNeg_S] ,
   CONSTRAINT [DF_Profile_SQIntCate_I] DEFAULT (0) FOR [SQIntCate_I] ,
   CONSTRAINT [DF_Profile_SQIntCate_E] DEFAULT (0) FOR [SQIntCate_E] ,
   CONSTRAINT [DF_Profile_SQIntCate_S] DEFAULT (0) FOR [SQIntCate_S] ,
   CONSTRAINT [DF_Profile_SQInt] DEFAULT (0) FOR [SQInt] ,
   CONSTRAINT [DF_Profile_SQIntPerc] DEFAULT (0) FOR [SQIntPerc] ,
   CONSTRAINT [DF_Profile_SQDI] DEFAULT (0) FOR [SQDI] ,
   CONSTRAINT [DF_Profile_SQDIS] DEFAULT (0) FOR [SQDIS] ,
   CONSTRAINT [DF_Profile_SQLeft] DEFAULT (0) FOR [SQLeft] ,
   CONSTRAINT [DF_Profile_SQRight] DEFAULT (0) FOR [SQRight] ,
   CONSTRAINT [DF_Profile_SQAI] DEFAULT (0) FOR [SQAI] ,
   CONSTRAINT [DF_Profile_BQrLeft] DEFAULT (0) FOR [BQrLeft] ,
   CONSTRAINT [DF_Profile_BQrRight] DEFAULT (0) FOR [BQrRight] ,
   CONSTRAINT [DF_Profile_BQaLeft] DEFAULT (0) FOR [BQaLeft] ,
   CONSTRAINT [DF_Profile_BQaRight] DEFAULT (0) FOR [BQaRight] ,
   CONSTRAINT [DF_Profile_CQLeft] DEFAULT (0) FOR [CQLeft] ,
   CONSTRAINT [DF_Profile_CQRight] DEFAULT (0) FOR [CQRight] ,
   CONSTRAINT [DF_Profile_RQLeft] DEFAULT (0) FOR [RQLeft] ,
   CONSTRAINT [DF_Profile_RQRight] DEFAULT (0) FOR [RQRight] ,
   CONSTRAINT [DF_Profile_VQClarity_I] DEFAULT (0) FOR [VQClarity_I] ,
   CONSTRAINT [DF_Profile_VQClarity_E] DEFAULT (0) FOR [VQClarity_E] ,
   CONSTRAINT [DF_Profile_VQClarity_S] DEFAULT (0) FOR [VQClarity_S] ,
   CONSTRAINT [DF_Profile_VQBias_I] DEFAULT (0) FOR [VQBias_I] ,
   CONSTRAINT [DF_Profile_VQBias_E] DEFAULT (0) FOR [VQBias_E] ,
   CONSTRAINT [DF_Profile_VQBias_S] DEFAULT (0) FOR [VQBias_S] ,
   CONSTRAINT [DF_Profile_SQClarity_I] DEFAULT (0) FOR [SQClarity_I] ,
   CONSTRAINT [DF_Profile_SQClarity_E] DEFAULT (0) FOR [SQClarity_E] ,
   CONSTRAINT [DF_Profile_SQClarity_S] DEFAULT (0) FOR [SQClarity_S] ,
   CONSTRAINT [DF_Profile_SQBias_I] DEFAULT (0) FOR [SQBias_I] ,
   CONSTRAINT [DF_Profile_SQBias_E] DEFAULT (0) FOR [SQBias_E] ,
   CONSTRAINT [DF_Profile_SQBias_S] DEFAULT (0) FOR [SQBias_S] ,
   CONSTRAINT [DF_Profile_xVQClarity_I] DEFAULT (0) FOR [xVQClarity_I] ,
   CONSTRAINT [DF_Profile_xVQClarity_E] DEFAULT (0) FOR [xVQClarity_E] ,
   CONSTRAINT [DF_Profile_xVQClarity_S] DEFAULT (0) FOR [xVQClarity_S] ,
   CONSTRAINT [DF_Profile_xVQBias_I] DEFAULT (0) FOR [xVQBias_I] ,
   CONSTRAINT [DF_Profile_xVQBias_E] DEFAULT (0) FOR [xVQBias_E] ,
   CONSTRAINT [DF_Profile_xVQBias_S] DEFAULT (0) FOR [xVQBias_S] ,
   CONSTRAINT [DF_Profile_xSQClarity_I] DEFAULT (0) FOR [xSQClarity_I] ,
   CONSTRAINT [DF_Profile_xSQClarity_E] DEFAULT (0) FOR [xSQClarity_E] ,
   CONSTRAINT [DF_Profile_xSQClarity_S] DEFAULT (0) FOR [xSQClarity_S] ,
   CONSTRAINT [DF_Profile_xSQBias_I] DEFAULT (0) FOR [xSQBias_I] ,
   CONSTRAINT [DF_Profile_xSQBias_E] DEFAULT (0) FOR [xSQBias_E] ,
   CONSTRAINT [DF_Profile_xSQBias_S] DEFAULT (0) FOR [xSQBias_S]
GO

ALTER TABLE [dbo].[Profile] WITH NOCHECK ADD
   CONSTRAINT [PK_Profile] PRIMARY KEY NONCLUSTERED
   ([ProfileID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Profile_MemberID]
   ON [dbo].[Profile]
   ([MemberID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO