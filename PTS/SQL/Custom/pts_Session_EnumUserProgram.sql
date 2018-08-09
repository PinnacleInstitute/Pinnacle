EXEC [dbo].pts_CheckProc 'pts_Session_EnumUserProgram'
GO

--EXEC pts_Session_EnumUserProgram 13, 84, 0

CREATE PROCEDURE [dbo].pts_Session_EnumUserProgram
   @SessionID int ,
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = @SessionID

SELECT DISTINCT og.OrgID AS 'ID', og.OrgName AS 'Name'
FROM  Session AS se (NOLOCK)
JOIN  OrgCourse AS oc (NOLOCK) ON se.CourseID = oc.CourseID
JOIN  Org AS og (NOLOCK) ON oc.OrgID = og.OrgID
WHERE se.MemberID = @MemberID
AND   og.CompanyID = @CompanyID
AND   og.IsProgram <> 0
ORDER BY og.OrgName

GO



