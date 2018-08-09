EXEC [dbo].pts_CheckProc 'pts_Prepaid_Add'
 GO

CREATE PROCEDURE [dbo].pts_Prepaid_Add ( 
   @PrepaidID int OUTPUT,
   @MemberID int,
   @RefID int,
   @PayDate datetime,
   @PayType int,
   @Amount money,
   @Note varchar (100),
   @BV money,
   @Bonus int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Prepaid (
            MemberID , 
            RefID , 
            PayDate , 
            PayType , 
            Amount , 
            Note , 
            BV , 
            Bonus
            )
VALUES (
            @MemberID ,
            @RefID ,
            @PayDate ,
            @PayType ,
            @Amount ,
            @Note ,
            @BV ,
            @Bonus            )

SET @mNewID = @@IDENTITY

SET @PrepaidID = @mNewID

GO