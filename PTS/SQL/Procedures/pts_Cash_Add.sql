EXEC [dbo].pts_CheckProc 'pts_Cash_Add'
 GO

CREATE PROCEDURE [dbo].pts_Cash_Add ( 
   @CashID int OUTPUT,
   @MemberID int,
   @RefID int,
   @CashDate datetime,
   @CashType int,
   @Amount money,
   @Note varchar (100),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Cash (
            MemberID , 
            RefID , 
            CashDate , 
            CashType , 
            Amount , 
            Note
            )
VALUES (
            @MemberID ,
            @RefID ,
            @CashDate ,
            @CashType ,
            @Amount ,
            @Note            )

SET @mNewID = @@IDENTITY

SET @CashID = @mNewID

GO