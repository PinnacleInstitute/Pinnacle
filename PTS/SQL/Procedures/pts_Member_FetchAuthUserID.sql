EXEC [dbo].pts_CheckProc 'pts_Member_FetchAuthUserID'
GO

CREATE PROCEDURE [dbo].pts_Member_FetchAuthUserID
   @MemberID int ,
   @UserID int ,
   @AuthUserID int OUTPUT
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

SELECT      @mAuthUserID = me.AuthUserID
FROM Member AS me (NOLOCK)
WHERE (me.MemberID = @MemberID)


SET @AuthUserID = ISNULL(@mAuthUserID, 0)
GO