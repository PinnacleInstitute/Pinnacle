EXEC [dbo].pts_CheckProc 'pts_NewsLetter_Update'
 GO

CREATE PROCEDURE [dbo].pts_NewsLetter_Update ( 
   @NewsLetterID int,
   @CompanyID int,
   @MemberID int,
   @NewsLetterName nvarchar (60),
   @Status int,
   @Description nvarchar (200),
   @MemberCnt int,
   @ProspectCnt int,
   @IsAttached bit,
   @IsFeatured bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE nl
SET nl.CompanyID = @CompanyID ,
   nl.MemberID = @MemberID ,
   nl.NewsLetterName = @NewsLetterName ,
   nl.Status = @Status ,
   nl.Description = @Description ,
   nl.MemberCnt = @MemberCnt ,
   nl.ProspectCnt = @ProspectCnt ,
   nl.IsAttached = @IsAttached ,
   nl.IsFeatured = @IsFeatured
FROM NewsLetter AS nl
WHERE nl.NewsLetterID = @NewsLetterID

GO