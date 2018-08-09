EXEC [dbo].pts_CheckProc 'pts_Member_Deactivate'
GO

CREATE PROCEDURE [dbo].pts_Member_Deactivate
   @MemberID int,
   @UserID int
AS

DECLARE   @mNow datetime, 
         @mNewID int

SET         NOCOUNT ON

SET         @mNow = GETDATE()

UPDATE   me
SET            me.Status = 5 ,
            me.ChangeDate = @mNow ,
            me.ChangeID = @UserID
FROM      Member AS me
WHERE      (me.MemberID = @MemberID)


GO