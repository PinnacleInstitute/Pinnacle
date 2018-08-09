EXEC [dbo].pts_CheckProc 'pts_MemberTitle_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberTitle_Add ( 
   @MemberTitleID int OUTPUT,
   @MemberID int,
   @TitleDate datetime,
   @Title int,
   @IsEarned bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberTitle (
            MemberID , 
            TitleDate , 
            Title , 
            IsEarned
            )
VALUES (
            @MemberID ,
            @TitleDate ,
            @Title ,
            @IsEarned            )

SET @mNewID = @@IDENTITY

SET @MemberTitleID = @mNewID

GO