EXEC [dbo].pts_CheckProc 'pts_Employee_ListActive'
GO

CREATE PROCEDURE [dbo].pts_Employee_ListActive
   @UserID int
AS

SET NOCOUNT ON

SELECT      em.EmployeeID, 
         LTRIM(RTRIM(em.NameFirst)) +  ' '  + LTRIM(RTRIM(em.NameLast)) +  ''  AS 'EmployeeName', 
         em.NameFirst
FROM Employee AS em (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (em.AuthUserID = au.AuthUserID)
WHERE (au.UserGroup > 0)
 AND (au.UserStatus = 1)

ORDER BY   em.NameFirst

GO