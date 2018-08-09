EXEC [dbo].pts_CheckProc 'pts_Org_ListFavoriteAll'
GO

CREATE PROCEDURE [dbo].pts_Org_ListFavoriteAll
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

	SELECT OrgID, OrgName, CompanyID
	FROM Org (NOLOCK)
	WHERE (CompanyID = @CompanyID)
	AND (Status = 2)
	AND (IsFavorite = 1)
	
	UNION ALL
	SELECT OrgID, OrgName, CompanyID
	FROM Org (NOLOCK)
	WHERE (CompanyID = 2)
	AND (Status = 2)
	AND (IsFavorite = 1)

ORDER BY CompanyID DESC, OrgName

GO