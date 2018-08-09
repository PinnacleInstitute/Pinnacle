EXEC [dbo].pts_CheckProc 'pts_SalesOrder_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesOrder_Fetch ( 
   @SalesOrderID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @ProspectID int OUTPUT,
   @AffiliateID int OUTPUT,
   @PromotionID int OUTPUT,
   @PartyID int OUTPUT,
   @AddressID int OUTPUT,
   @NameLast nvarchar (30) OUTPUT,
   @NameFirst nvarchar (30) OUTPUT,
   @MemberName nvarchar (62) OUTPUT,
   @ProspectName nvarchar (60) OUTPUT,
   @PromotionName nvarchar (60) OUTPUT,
   @OrderDate datetime OUTPUT,
   @Amount money OUTPUT,
   @Tax money OUTPUT,
   @Total money OUTPUT,
   @Status int OUTPUT,
   @Notes nvarchar (1000) OUTPUT,
   @Discount money OUTPUT,
   @Shipping money OUTPUT,
   @Ship int OUTPUT,
   @IsTaxable bit OUTPUT,
   @IsRecur bit OUTPUT,
   @PinnDate datetime OUTPUT,
   @PinnAmount money OUTPUT,
   @CommDate datetime OUTPUT,
   @CommAmount money OUTPUT,
   @AutoShip int OUTPUT,
   @IsActive bit OUTPUT,
   @BV money OUTPUT,
   @Track varchar (40) OUTPUT,
   @Valid int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = so.CompanyID ,
   @MemberID = so.MemberID ,
   @ProspectID = so.ProspectID ,
   @AffiliateID = so.AffiliateID ,
   @PromotionID = so.PromotionID ,
   @PartyID = so.PartyID ,
   @AddressID = so.AddressID ,
   @NameLast = me.NameLast ,
   @NameFirst = me.NameFirst ,
   @MemberName = LTRIM(RTRIM(me.NameLast)) +  ', '  + LTRIM(RTRIM(me.NameFirst)) ,
   @ProspectName = pr.ProspectName ,
   @PromotionName = pm.PromotionName ,
   @OrderDate = so.OrderDate ,
   @Amount = so.Amount ,
   @Tax = so.Tax ,
   @Total = so.Total ,
   @Status = so.Status ,
   @Notes = so.Notes ,
   @Discount = so.Discount ,
   @Shipping = so.Shipping ,
   @Ship = so.Ship ,
   @IsTaxable = so.IsTaxable ,
   @IsRecur = so.IsRecur ,
   @PinnDate = so.PinnDate ,
   @PinnAmount = so.PinnAmount ,
   @CommDate = so.CommDate ,
   @CommAmount = so.CommAmount ,
   @AutoShip = so.AutoShip ,
   @IsActive = so.IsActive ,
   @BV = so.BV ,
   @Track = so.Track ,
   @Valid = so.Valid
FROM SalesOrder AS so (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (so.MemberID = me.MemberID)
LEFT OUTER JOIN Prospect AS pr (NOLOCK) ON (so.ProspectID = pr.ProspectID)
LEFT OUTER JOIN Promotion AS pm (NOLOCK) ON (so.PromotionID = pm.PromotionID)
WHERE so.SalesOrderID = @SalesOrderID

GO