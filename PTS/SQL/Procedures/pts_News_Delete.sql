EXEC [dbo].pts_CheckProc 'pts_News_Delete'
 GO

CREATE PROCEDURE [dbo].pts_News_Delete ( 
   @NewsID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE nw
FROM News AS nw
WHERE nw.NewsID = @NewsID

GO