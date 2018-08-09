EXEC [dbo].pts_CheckProc 'pts_NewsLetter_Add'
 GO

CREATE PROCEDURE [dbo].pts_NewsLetter_Add ( 
   @NewsLetterID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO NewsLetter (
            CompanyID , 
            MemberID , 
            NewsLetterName , 
            Status , 
            Description , 
            MemberCnt , 
            ProspectCnt , 
            IsAttached , 
            IsFeatured
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @NewsLetterName ,
            @Status ,
            @Description ,
            @MemberCnt ,
            @ProspectCnt ,
            @IsAttached ,
            @IsFeatured            )

SET @mNewID = @@IDENTITY

SET @NewsLetterID = @mNewID

GO