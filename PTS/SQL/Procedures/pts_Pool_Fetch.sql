EXEC [dbo].pts_CheckProc 'pts_Pool_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Pool_Fetch ( 
   @PoolID int,
   @MemberID int OUTPUT,
   @PoolDate datetime OUTPUT,
   @PoolType int OUTPUT,
   @Amount money OUTPUT,
   @Distributed money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = poo.MemberID ,
   @PoolDate = poo.PoolDate ,
   @PoolType = poo.PoolType ,
   @Amount = poo.Amount ,
   @Distributed = poo.Distributed
FROM Pool AS poo (NOLOCK)
WHERE poo.PoolID = @PoolID

GO