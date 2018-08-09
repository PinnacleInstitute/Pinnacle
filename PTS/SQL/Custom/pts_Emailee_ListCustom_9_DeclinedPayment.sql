EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_9_DeclinedPayment'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_9_DeclinedPayment
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @IncludeCode nvarchar (80), @ExcludeCode nvarchar (80)

IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

SET @IncludeCode = LTRIM(RTRIM(@Data2))
SET @ExcludeCode = LTRIM(RTRIM(@Data3))

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       dbo.wtfn_DateOnly(pa.PayDate) AS 'Data3', 
       pa.Amount AS 'Data4',
       pa.Notes AS 'Data5'
FROM Payment AS pa (NOLOCK)
JOIN Member AS me ON pa.OwnerID = me.MemberID
JOIN Company AS co ON me.CompanyID = co.CompanyID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND pa.OwnerType = 4
AND pa.Status = 4
AND ( @IncludeCode = '' OR pa.Notes LIKE '%' + @IncludeCode + '%' )
AND ( @ExcludeCode = '' OR pa.Notes NOT LIKE '%' + @ExcludeCode + '%' )

GO