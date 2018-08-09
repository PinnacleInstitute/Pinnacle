EXEC [dbo].pts_CheckProc 'pts_Seminar_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_Delete ( 
   @SeminarID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE sem
FROM Seminar AS sem
WHERE sem.SeminarID = @SeminarID

GO