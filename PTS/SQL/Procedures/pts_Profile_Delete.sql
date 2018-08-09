EXEC [dbo].pts_CheckProc 'pts_Profile_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Profile_Delete ( 
   @ProfileID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE pro
FROM Profile AS pro
WHERE pro.ProfileID = @ProfileID

GO