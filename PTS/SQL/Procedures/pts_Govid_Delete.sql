EXEC [dbo].pts_CheckProc 'pts_Govid_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Govid_Delete ( 
   @GovidID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE gi
FROM Govid AS gi
WHERE gi.GovidID = @GovidID

GO