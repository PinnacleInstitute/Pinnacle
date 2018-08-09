EXEC [dbo].pts_CheckProc 'pts_Pool_Add'
 GO

CREATE PROCEDURE [dbo].pts_Pool_Add ( 
   @PoolID int OUTPUT,
   @MemberID int,
   @PoolDate datetime,
   @PoolType int,
   @Amount money,
   @Distributed money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Pool (
            MemberID , 
            PoolDate , 
            PoolType , 
            Amount , 
            Distributed
            )
VALUES (
            @MemberID ,
            @PoolDate ,
            @PoolType ,
            @Amount ,
            @Distributed            )

SET @mNewID = @@IDENTITY

SET @PoolID = @mNewID

GO