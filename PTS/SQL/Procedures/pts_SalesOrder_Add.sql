EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesOrder_Add ( 
   @SalesOrderID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @ProspectID int,
   @AffiliateID int,
   @PromotionID int,
   @PartyID int,
   @AddressID int,
   @OrderDate datetime,
   @Amount money,
   @Tax money,
   @Total money,
   @Status int,
   @Notes nvarchar (1000),
   @Discount money,
   @Shipping money,
   @Ship int,
   @IsTaxable bit,
   @IsRecur bit,
   @PinnDate datetime,
   @PinnAmount money,
   @CommDate datetime,
   @CommAmount money,
   @AutoShip int,
   @IsActive bit,
   @BV money,
   @Track varchar (40),
   @Valid int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO SalesOrder (
            CompanyID , 
            MemberID , 
            ProspectID , 
            AffiliateID , 
            PromotionID , 
            PartyID , 
            AddressID , 
            OrderDate , 
            Amount , 
            Tax , 
            Total , 
            Status , 
            Notes , 
            Discount , 
            Shipping , 
            Ship , 
            IsTaxable , 
            IsRecur , 
            PinnDate , 
            PinnAmount , 
            CommDate , 
            CommAmount , 
            AutoShip , 
            IsActive , 
            BV , 
            Track , 
            Valid
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @ProspectID ,
            @AffiliateID ,
            @PromotionID ,
            @PartyID ,
            @AddressID ,
            @OrderDate ,
            @Amount ,
            @Tax ,
            @Total ,
            @Status ,
            @Notes ,
            @Discount ,
            @Shipping ,
            @Ship ,
            @IsTaxable ,
            @IsRecur ,
            @PinnDate ,
            @PinnAmount ,
            @CommDate ,
            @CommAmount ,
            @AutoShip ,
            @IsActive ,
            @BV ,
            @Track ,
            @Valid            )

SET @mNewID = @@IDENTITY

SET @SalesOrderID = @mNewID

GO