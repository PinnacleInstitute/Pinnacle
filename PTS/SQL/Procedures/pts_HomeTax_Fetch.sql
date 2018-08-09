EXEC [dbo].pts_CheckProc 'pts_HomeTax_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_HomeTax_Fetch ( 
   @HomeTaxID int,
   @MemberID int OUTPUT,
   @TaxRate int OUTPUT,
   @Office int OUTPUT,
   @Miles int OUTPUT,
   @Home money OUTPUT,
   @Meetings money OUTPUT,
   @Meals money OUTPUT,
   @Supplies money OUTPUT,
   @Gifts money OUTPUT,
   @Materials money OUTPUT,
   @Phones money OUTPUT,
   @Internet money OUTPUT,
   @Kids money OUTPUT,
   @Subscriptions money OUTPUT,
   @Entertainment money OUTPUT,
   @Activities money OUTPUT,
   @Events money OUTPUT,
   @Medical money OUTPUT,
   @Recreational money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ht.MemberID ,
   @TaxRate = ht.TaxRate ,
   @Office = ht.Office ,
   @Miles = ht.Miles ,
   @Home = ht.Home ,
   @Meetings = ht.Meetings ,
   @Meals = ht.Meals ,
   @Supplies = ht.Supplies ,
   @Gifts = ht.Gifts ,
   @Materials = ht.Materials ,
   @Phones = ht.Phones ,
   @Internet = ht.Internet ,
   @Kids = ht.Kids ,
   @Subscriptions = ht.Subscriptions ,
   @Entertainment = ht.Entertainment ,
   @Activities = ht.Activities ,
   @Events = ht.Events ,
   @Medical = ht.Medical ,
   @Recreational = ht.Recreational
FROM HomeTax AS ht (NOLOCK)
WHERE ht.HomeTaxID = @HomeTaxID

GO