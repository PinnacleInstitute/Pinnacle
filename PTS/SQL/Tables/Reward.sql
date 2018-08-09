EXEC [dbo].pts_CheckTable 'Reward'
 GO

CREATE TABLE [dbo].[Reward] (
   [RewardID] int IDENTITY (1,1) NOT NULL ,
   [MerchantID] int NOT NULL ,
   [ConsumerID] int NOT NULL ,
   [Payment2ID] int NOT NULL ,
   [AwardID] int NOT NULL ,
   [RewardDate] datetime NOT NULL ,
   [RewardType] int NOT NULL ,
   [Amount] bigint NOT NULL ,
   [Status] int NOT NULL ,
   [HoldDate] datetime NOT NULL ,
   [Reference] nvarchar (15) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL ,
   [Note] nvarchar (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL 
   ) ON [PRIMARY]
GO

ALTER TABLE [dbo].[Reward] WITH NOCHECK ADD
   CONSTRAINT [DF_Reward_MerchantID] DEFAULT (0) FOR [MerchantID] ,
   CONSTRAINT [DF_Reward_ConsumerID] DEFAULT (0) FOR [ConsumerID] ,
   CONSTRAINT [DF_Reward_Payment2ID] DEFAULT (0) FOR [Payment2ID] ,
   CONSTRAINT [DF_Reward_AwardID] DEFAULT (0) FOR [AwardID] ,
   CONSTRAINT [DF_Reward_RewardDate] DEFAULT (0) FOR [RewardDate] ,
   CONSTRAINT [DF_Reward_RewardType] DEFAULT (0) FOR [RewardType] ,
   CONSTRAINT [DF_Reward_Amount] DEFAULT (0) FOR [Amount] ,
   CONSTRAINT [DF_Reward_Status] DEFAULT (0) FOR [Status] ,
   CONSTRAINT [DF_Reward_HoldDate] DEFAULT (0) FOR [HoldDate] ,
   CONSTRAINT [DF_Reward_Reference] DEFAULT ('') FOR [Reference] ,
   CONSTRAINT [DF_Reward_Note] DEFAULT ('') FOR [Note]
GO

ALTER TABLE [dbo].[Reward] WITH NOCHECK ADD
   CONSTRAINT [PK_Reward] PRIMARY KEY NONCLUSTERED
   ([RewardID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Reward_MerchantID]
   ON [dbo].[Reward]
   ([MerchantID], [ConsumerID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Reward_MerchantDate]
   ON [dbo].[Reward]
   ([MerchantID], [RewardDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Reward_ConsumerID]
   ON [dbo].[Reward]
   ([ConsumerID], [MerchantID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Reward_ConsumerDate]
   ON [dbo].[Reward]
   ([ConsumerID], [RewardDate])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO

CREATE INDEX [I_Reward_Payment2ID]
   ON [dbo].[Reward]
   ([Payment2ID])
   WITH FILLFACTOR = 80 ON [PRIMARY]
GO