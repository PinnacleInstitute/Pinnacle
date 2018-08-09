EXEC [dbo].pts_CheckProc 'pts_HomeTax_Update'
 GO

CREATE PROCEDURE [dbo].pts_HomeTax_Update ( 
   @HomeTaxID int,
   @MemberID int,
   @TaxRate int,
   @Office int,
   @Miles int,
   @Home money,
   @Meetings money,
   @Meals money,
   @Supplies money,
   @Gifts money,
   @Materials money,
   @Phones money,
   @Internet money,
   @Kids money,
   @Subscriptions money,
   @Entertainment money,
   @Activities money,
   @Events money,
   @Medical money,
   @Recreational money,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ht
SET ht.MemberID = @MemberID ,
   ht.TaxRate = @TaxRate ,
   ht.Office = @Office ,
   ht.Miles = @Miles ,
   ht.Home = @Home ,
   ht.Meetings = @Meetings ,
   ht.Meals = @Meals ,
   ht.Supplies = @Supplies ,
   ht.Gifts = @Gifts ,
   ht.Materials = @Materials ,
   ht.Phones = @Phones ,
   ht.Internet = @Internet ,
   ht.Kids = @Kids ,
   ht.Subscriptions = @Subscriptions ,
   ht.Entertainment = @Entertainment ,
   ht.Activities = @Activities ,
   ht.Events = @Events ,
   ht.Medical = @Medical ,
   ht.Recreational = @Recreational
FROM HomeTax AS ht
WHERE ht.HomeTaxID = @HomeTaxID

GO