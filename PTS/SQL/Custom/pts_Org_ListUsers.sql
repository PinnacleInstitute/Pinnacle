EXEC [dbo].pts_CheckProc 'pts_Org_ListUsers'
GO
--exec pts_Org_ListUsers 14

CREATE PROCEDURE [dbo].pts_Org_ListUsers
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      org.OrgID, 
         org.NameFirst, 
         org.NameLast, 
         org.Email, 
         org.Secure, 
         au.UserGroup AS 'UserGroup', 
         au.UserStatus AS 'UserStatus',
         org.Description
FROM Org AS org (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (org.AuthUserID = au.AuthUserID)
WHERE (org.CompanyID = @CompanyID)
 AND (org.AuthUserID <> 0)

ORDER BY   org.NameFirst

GO