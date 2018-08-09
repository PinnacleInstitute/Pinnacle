EXEC [dbo].pts_CheckProc 'pts_Emailee_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Emailee_Delete ( 
   @EmaileeID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE eme
FROM Emailee AS eme
WHERE eme.EmaileeID = @EmaileeID

GO