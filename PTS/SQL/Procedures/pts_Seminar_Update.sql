EXEC [dbo].pts_CheckProc 'pts_Seminar_Update'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_Update ( 
   @SeminarID int,
   @CompanyID int,
   @MemberID int,
   @SeminarName nvarchar (100),
   @Description nvarchar (1000),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sem
SET sem.CompanyID = @CompanyID ,
   sem.MemberID = @MemberID ,
   sem.SeminarName = @SeminarName ,
   sem.Description = @Description ,
   sem.Status = @Status
FROM Seminar AS sem
WHERE sem.SeminarID = @SeminarID

GO