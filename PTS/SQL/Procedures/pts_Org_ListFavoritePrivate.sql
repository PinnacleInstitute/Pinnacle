EXEC [dbo].pts_CheckProc 'pts_Org_ListFavoritePrivate'
GO

CREATE PROCEDURE [dbo].pts_Org_ListFavoritePrivate
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      org.OrgID, 
         org.OrgName
FROM Org AS org (NOLOCK)
WHERE (org.CompanyID = @CompanyID)
 AND (org.Status = 2)
 AND (org.IsFavorite = 1)

ORDER BY   org.OrgName

GO