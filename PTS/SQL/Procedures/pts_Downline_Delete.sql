EXEC [dbo].pts_CheckProc 'pts_Downline_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Downline_Delete ( 
   @DownlineID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE dl
FROM Downline AS dl
WHERE dl.DownlineID = @DownlineID

GO