EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_91'
GO

--TEST
--EXEC pts_Emailee_ListCustom_91 13, '743', '', '', '', ''

-- Course Completion Date Range
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_91
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CourseID int, @FromDate datetime, @ToDate datetime

IF @Data1 != '' 
	SET @CourseID = CAST(@Data1 AS int)
Else
	SET @CourseID = 0

IF @Data2 != '' 
	SET @FromDate = CAST(@Data2 AS datetime)
Else
	SET @FromDate = 0

IF @Data3 != '' 
	SET @ToDate = CAST(@Data3 AS datetime)
Else
	SET @ToDate = 0

SELECT se.SessionID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       cr.CourseName AS 'Data1', 
       dbo.wtfn_DateOnlyStr(se.CompleteDate) AS 'Data2',
       CAST(se.Status AS nvarchar(20)) AS 'Data3',
       CAST(se.Grade AS nvarchar(20)) AS 'Data4',
       '' AS 'Data5'
FROM Session AS se (NOLOCK)
JOIN Member AS me ON se.MemberID = me.MemberID
JOIN Course AS cr ON se.CourseID = cr.CourseID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND se.CourseID = @CourseID
AND se.Status >= 5
AND ( @FromDate = 0 OR se.CompleteDate >= @FromDate ) 
AND ( @ToDate = 0 OR se.CompleteDate <= @ToDate ) 
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
