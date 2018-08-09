EXEC [dbo].pts_CheckProc 'pts_Seminar_Add'
 GO

CREATE PROCEDURE [dbo].pts_Seminar_Add ( 
   @SeminarID int OUTPUT,
   @CompanyID int,
   @MemberID int,
   @SeminarName nvarchar (100),
   @Description nvarchar (1000),
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Seminar (
            CompanyID , 
            MemberID , 
            SeminarName , 
            Description , 
            Status
            )
VALUES (
            @CompanyID ,
            @MemberID ,
            @SeminarName ,
            @Description ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @SeminarID = @mNewID

GO