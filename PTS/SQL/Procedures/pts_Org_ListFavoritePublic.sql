EXEC [dbo].pts_CheckProc 'pts_Org_ListFavoritePublic'
GO

CREATE PROCEDURE [dbo].pts_Org_ListFavoritePublic
   @UserID int
AS

SET NOCOUNT ON

SELECT      org.OrgID, 
         org.OrgName
FROM Org AS org (NOLOCK)
WHERE (org.CompanyID = 2)
 AND (org.Status = 2)
 AND (org.IsFavorite = 1)

ORDER BY   org.OrgName

GO