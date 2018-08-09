EXEC [dbo].pts_CheckProc 'pts_Commission_FindPayoutCommTypeName'
 GO

CREATE PROCEDURE [dbo].pts_Commission_FindPayoutCommTypeName ( 
   @SearchText nvarchar (40),
   @Bookmark nvarchar (50),
   @MaxRows tinyint OUTPUT,
   @PayoutID int,
   @CommType int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(ct.CommTypeName, '') + dbo.wtfn_FormatNumber(co.CommissionID, 10) 'BookMark' ,
            co.CommissionID 'CommissionID' ,
            co.CompanyID 'CompanyID' ,
            co.OwnerType 'OwnerType' ,
            co.OwnerID 'OwnerID' ,
            co.PayoutID 'PayoutID' ,
            co.RefID 'RefID' ,
            ct.CommTypeName 'CommTypeName' ,
            co.CommDate 'CommDate' ,
            co.Status 'Status' ,
            co.CommType 'CommType' ,
            co.Amount 'Amount' ,
            co.Total 'Total' ,
            co.Charge 'Charge' ,
            co.Description 'Description' ,
            co.Notes 'Notes' ,
            co.Show 'Show'
FROM Commission AS co (NOLOCK)
LEFT OUTER JOIN CommType AS ct (NOLOCK) ON (co.CompanyID = ct.CompanyID AND co.CommType = ct.CommTypeNo)
WHERE ISNULL(ct.CommTypeName, '') LIKE @SearchText + '%'
AND ISNULL(ct.CommTypeName, '') + dbo.wtfn_FormatNumber(co.CommissionID, 10) >= @BookMark
AND         (co.PayoutID = @PayoutID)
AND         (co.CommType = @CommType)
ORDER BY 'Bookmark'

GO