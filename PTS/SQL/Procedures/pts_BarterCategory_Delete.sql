EXEC [dbo].pts_CheckProc 'pts_BarterCategory_Delete'
 GO

CREATE PROCEDURE [dbo].pts_BarterCategory_Delete ( 
   @BarterCategoryID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE bca
FROM BarterCategory AS bca
WHERE bca.BarterCategoryID = @BarterCategoryID

GO