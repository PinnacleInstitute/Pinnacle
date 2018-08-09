EXEC [dbo].pts_CheckProc 'pts_Reward_Add'
 GO

CREATE PROCEDURE [dbo].pts_Reward_Add ( 
   @RewardID int OUTPUT,
   @MerchantID int,
   @ConsumerID int,
   @Payment2ID int,
   @AwardID int,
   @RewardDate datetime,
   @RewardType int,
   @Amount bigint,
   @Status int,
   @HoldDate datetime,
   @Reference nvarchar (15),
   @Note nvarchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Reward (
            MerchantID , 
            ConsumerID , 
            Payment2ID , 
            AwardID , 
            RewardDate , 
            RewardType , 
            Amount , 
            Status , 
            HoldDate , 
            Reference , 
            Note
            )
VALUES (
            @MerchantID ,
            @ConsumerID ,
            @Payment2ID ,
            @AwardID ,
            @RewardDate ,
            @RewardType ,
            @Amount ,
            @Status ,
            @HoldDate ,
            @Reference ,
            @Note            )

SET @mNewID = @@IDENTITY

SET @RewardID = @mNewID

GO