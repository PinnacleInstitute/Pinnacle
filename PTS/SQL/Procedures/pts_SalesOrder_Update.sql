EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Update'
GO

CREATE PROCEDURE [dbo].pts_SalesOrder_Update
   @SalesOrderID int,
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
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE so
SET so.CompanyID = @CompanyID ,
   so.MemberID = @MemberID ,
   so.ProspectID = @ProspectID ,
   so.AffiliateID = @AffiliateID ,
   so.PromotionID = @PromotionID ,
   so.PartyID = @PartyID ,
   so.AddressID = @AddressID ,
   so.OrderDate = @OrderDate ,
   so.Amount = @Amount ,
   so.Tax = @Tax ,
   so.Total = @Total ,
   so.Status = @Status ,
   so.Notes = @Notes ,
   so.Discount = @Discount ,
   so.Shipping = @Shipping ,
   so.Ship = @Ship ,
   so.IsTaxable = @IsTaxable ,
   so.IsRecur = @IsRecur ,
   so.PinnDate = @PinnDate ,
   so.PinnAmount = @PinnAmount ,
   so.CommDate = @CommDate ,
   so.CommAmount = @CommAmount ,
   so.AutoShip = @AutoShip ,
   so.IsActive = @IsActive ,
   so.BV = @BV ,
   so.Track = @Track ,
   so.Valid = @Valid
FROM SalesOrder AS so
WHERE (so.SalesOrderID = @SalesOrderID)


EXEC pts_SalesOrder_ComputeTotalPrice
   @SalesOrderID

GO