EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_10_PaymentStatus'
GO

--EXEC pts_Emailee_ListCustom_10_PaymentStatus '', '', '', '', ''

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_10_PaymentStatus
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Status int, @FromDate datetime, @ToDate datetime

IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

IF @Data2 != '' 
	SET @Status = CAST(@Data2 AS int)
Else
	SET @Status = 0

IF @Data3 != '' 
	SET @FromDate = CAST(@Data3 AS datetime)
Else
	SET @FromDate = 0

IF @Data4 != '' 
	SET @ToDate = CAST(@Data4 AS datetime)
Else
	SET @ToDate = '12/31/2099'


SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       au.Logon AS 'Data3', 
       dbo.wtfn_DateOnly(pa.PayDate) AS 'Data4', 
       pa.Amount AS 'Data5'
FROM Payment AS pa (NOLOCK)
JOIN Member AS me ON pa.OwnerID = me.MemberID
JOIN Company AS co ON me.CompanyID = co.CompanyID
JOIN ORG AS og ON (co.CompanyID = og.CompanyID AND og.ParentID = 0)
LEFT OUTER JOIN AUTHUSER AS au ON og.AuthUserID = au.AuthUserID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND pa.OwnerType = 4
AND ( @Status = 0 OR @Status = pa.Status )
AND ( @FromDate = 0 OR pa.PayDate >= @FromDate ) 
AND ( @ToDate = 0 OR pa.PayDate <= @ToDate ) 

GO