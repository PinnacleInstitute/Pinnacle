EXEC [dbo].pts_CheckProc 'pts_Pool_Update'
 GO

CREATE PROCEDURE [dbo].pts_Pool_Update ( 
   @PoolID int,
   @MemberID int,
   @PoolDate datetime,
   @PoolType int,
   @Amount money,
   @Distributed money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE poo
SET poo.MemberID = @MemberID ,
   poo.PoolDate = @PoolDate ,
   poo.PoolType = @PoolType ,
   poo.Amount = @Amount ,
   poo.Distributed = @Distributed
FROM Pool AS poo
WHERE poo.PoolID = @PoolID

GO