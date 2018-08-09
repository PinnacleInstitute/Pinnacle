EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_3_ClassesCompleted'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_3_ClassesCompleted
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Days int, @Now datetime
IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

IF @Data2 != '' 
	SET @Days = CAST(@Data2 AS int)
Else
	SET @Days = 1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT se.SessionID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       cr.CourseName AS 'Data3', 
       dbo.wtfn_DateOnlyStr(se.CompleteDate) AS 'Data4',
       CAST(se.Status AS nvarchar(80)) AS 'Data5'
         
FROM Session AS se (NOLOCK)
JOIN Member AS me ON se.MemberID = me.MemberID
JOIN Course AS cr ON se.CourseID = cr.CourseID
JOIN Company AS co ON me.CompanyID = co.CompanyID

WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND se.Status >= 5
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(se.CompleteDate)) = @Now

GO
