EXEC [dbo].pts_CheckProc 'pts_Reward_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Reward_Delete ( 
   @RewardID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE rew
FROM Reward AS rew
WHERE rew.RewardID = @RewardID

GO