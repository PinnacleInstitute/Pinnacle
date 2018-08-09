EXEC [dbo].pts_CheckProc 'pts_Org_ListActiveUsers'
GO

CREATE PROCEDURE [dbo].pts_Org_ListActiveUsers
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      org.OrgID, 
         LTRIM(RTRIM(org.NameLast)) +  ', '  + LTRIM(RTRIM(org.NameFirst)) AS 'ContactName', 
         org.NameFirst
FROM Org AS org (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (org.AuthUserID = au.AuthUserID)
WHERE (org.CompanyID = @CompanyID)
 AND (au.UserGroup > 0)
 AND (au.UserStatus = 1)

ORDER BY   org.NameFirst

GO