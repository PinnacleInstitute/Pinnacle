EXEC [dbo].pts_CheckProc 'pts_Commission_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Commission_Fetch ( 
   @CommissionID int,
   @CompanyID int OUTPUT,
   @OwnerType int OUTPUT,
   @OwnerID int OUTPUT,
   @PayoutID int OUTPUT,
   @RefID int OUTPUT,
   @CommTypeName nvarchar (40) OUTPUT,
   @CommDate datetime OUTPUT,
   @Status int OUTPUT,
   @CommType int OUTPUT,
   @Amount money OUTPUT,
   @Total money OUTPUT,
   @Charge money OUTPUT,
   @Description varchar (100) OUTPUT,
   @Notes varchar (500) OUTPUT,
   @Show int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = co.CompanyID ,
   @OwnerType = co.OwnerType ,
   @OwnerID = co.OwnerID ,
   @PayoutID = co.PayoutID ,
   @RefID = co.RefID ,
   @CommTypeName = ct.CommTypeName ,
   @CommDate = co.CommDate ,
   @Status = co.Status ,
   @CommType = co.CommType ,
   @Amount = co.Amount ,
   @Total = co.Total ,
   @Charge = co.Charge ,
   @Description = co.Description ,
   @Notes = co.Notes ,
   @Show = co.Show
FROM Commission AS co (NOLOCK)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
WHERE co.CommissionID = @CommissionID

GO