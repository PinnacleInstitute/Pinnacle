EXEC [dbo].pts_CheckProc 'pts_ProjectMember_Add'
 GO

CREATE PROCEDURE [dbo].pts_ProjectMember_Add ( 
   @ProjectMemberID int OUTPUT,
   @ProjectID int,
   @MemberID int,
   @Status int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO ProjectMember (
            ProjectID , 
            MemberID , 
            Status
            )
VALUES (
            @ProjectID ,
            @MemberID ,
            @Status            )

SET @mNewID = @@IDENTITY

SET @ProjectMemberID = @mNewID

GO