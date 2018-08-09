EXEC [dbo].pts_CheckProc 'pts_Seminar_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_Fetch ( 
   @SeminarID int,
   @CompanyID int OUTPUT,
   @MemberID int OUTPUT,
   @SeminarName nvarchar (100) OUTPUT,
   @Description nvarchar (1000) OUTPUT,
   @Status int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = sem.CompanyID ,
   @MemberID = sem.MemberID ,
   @SeminarName = sem.SeminarName ,
   @Description = sem.Description ,
   @Status = sem.Status
FROM Seminar AS sem (NOLOCK)
WHERE sem.SeminarID = @SeminarID

GO