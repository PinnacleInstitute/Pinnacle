EXEC [dbo].pts_CheckProc 'pts_Title_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Title_Delete ( 
   @TitleID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ti
FROM Title AS ti
WHERE ti.TitleID = @TitleID

GO