EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_89'
GO

--TEST
--EXEC pts_Emailee_ListCustom_89 13, '0', '1/1/05', '1/21/05', '', ''

-- All Members Enrollment Date Range
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_89
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Status int, @FromDate datetime, @ToDate datetime

IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = 0

IF @Data2 != '' 
	SET @FromDate = CAST(@Data2 AS datetime)
Else
	SET @FromDate = 0

IF @Data3 != '' 
	SET @ToDate = CAST(@Data3 AS datetime)
Else
	SET @ToDate = 0

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1', 
       dbo.wtfn_DateOnlyStr(me.VisitDate) AS 'Data2', 
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND ( @FromDate = 0 OR me.VisitDate >= @FromDate ) 
AND ( @ToDate = 0 OR me.VisitDate <= @ToDate ) 
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
