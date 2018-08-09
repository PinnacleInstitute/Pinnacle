EXEC [dbo].pts_CheckProc 'pts_MemberNews_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberNews_Add ( 
   @MemberNewsID int OUTPUT,
   @MemberID int,
   @NewsLetterID int,
   @EnrollDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberNews (
            MemberID , 
            NewsLetterID , 
            EnrollDate
            )
VALUES (
            @MemberID ,
            @NewsLetterID ,
            @EnrollDate            )

SET @mNewID = @@IDENTITY

SET @MemberNewsID = @mNewID

GO