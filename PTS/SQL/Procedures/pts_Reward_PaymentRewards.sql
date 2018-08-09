EXEC [dbo].pts_CheckProc 'pts_Reward_PaymentRewards'
GO

CREATE PROCEDURE [dbo].pts_Reward_PaymentRewards
   @Payment2ID int ,
   @Amount money ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO