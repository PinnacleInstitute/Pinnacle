EXEC [dbo].pts_CheckProc 'pts_Contest_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Contest_Delete ( 
   @ContestID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE con
FROM Contest AS con
WHERE con.ContestID = @ContestID

GO