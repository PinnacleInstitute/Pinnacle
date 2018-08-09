EXEC [dbo].pts_CheckProc 'pts_MemberNews_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberNews_Update ( 
   @MemberNewsID int,
   @MemberID int,
   @NewsLetterID int,
   @EnrollDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mn
SET mn.MemberID = @MemberID ,
   mn.NewsLetterID = @NewsLetterID ,
   mn.EnrollDate = @EnrollDate
FROM MemberNews AS mn
WHERE mn.MemberNewsID = @MemberNewsID

GO