EXEC [dbo].pts_CheckProc 'pts_Commission_Add'
 GO

CREATE PROCEDURE [dbo].pts_Commission_Add ( 
   @CommissionID int OUTPUT,
   @CompanyID int,
   @OwnerType int,
   @OwnerID int,
   @PayoutID int,
   @RefID int,
   @CommDate datetime,
   @Status int,
   @CommType int,
   @Amount money,
   @Total money,
   @Charge money,
   @Description varchar (100),
   @Notes varchar (500),
   @Show int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Commission (
            CompanyID , 
            OwnerType , 
            OwnerID , 
            PayoutID , 
            RefID , 
            CommDate , 
            Status , 
            CommType , 
            Amount , 
            Total , 
            Charge , 
            Description , 
            Notes , 
            Show
            )
VALUES (
            @CompanyID ,
            @OwnerType ,
            @OwnerID ,
            @PayoutID ,
            @RefID ,
            @CommDate ,
            @Status ,
            @CommType ,
            @Amount ,
            @Total ,
            @Charge ,
            @Description ,
            @Notes ,
            @Show            )

SET @mNewID = @@IDENTITY

SET @CommissionID = @mNewID

GO