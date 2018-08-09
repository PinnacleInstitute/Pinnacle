EXEC [dbo].pts_CheckProc 'pts_Page_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Page_Delete ( 
   @PageID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pg
FROM Page AS pg
WHERE pg.PageID = @PageID

GO