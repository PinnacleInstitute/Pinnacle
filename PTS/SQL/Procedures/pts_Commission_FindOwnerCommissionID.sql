EXEC [dbo].pts_CheckProc 'pts_Commission_FindOwnerCommissionID'
 GO

CREATE PROCEDURE [dbo].pts_Commission_FindOwnerCommissionID ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @FromDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), co.CommissionID), '') + dbo.wtfn_FormatNumber(co.CommissionID, 10) 'BookMark' ,
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
WHERE ISNULL(CONVERT(nvarchar(10), co.CommissionID), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), co.CommissionID), '') + dbo.wtfn_FormatNumber(co.CommissionID, 10) >= @BookMark
AND         (co.OwnerType = @OwnerType)
AND         (co.OwnerID = @OwnerID)
AND         (co.CommDate >= @FromDate)
AND         (co.CommDate <= @ToDate)
ORDER BY 'Bookmark'

GO