EXEC [dbo].pts_CheckProc 'pts_Company_Delete'
GO

CREATE PROCEDURE [dbo].pts_Company_Delete
   @CompanyID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   38 ,
   @CompanyID

DELETE com
FROM Company AS com
WHERE (com.CompanyID = @CompanyID)


GO