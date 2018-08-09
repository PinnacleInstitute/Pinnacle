EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_93'
GO

--TEST
--EXEC pts_Emailee_ListCustom_93 13, '743', '0', '', '', ''

-- Course Completed Day
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_93
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CourseID int, @Days int, @Now datetime
IF @Data1 != '' 
	SET @CourseID = CAST(@Data1 AS int)
Else
	SET @CourseID = 0

IF @Data2 != '' 
	SET @Days = CAST(@Data2 AS int)
Else
	SET @Days = 1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

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
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(se.CompleteDate)) = @Now
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
