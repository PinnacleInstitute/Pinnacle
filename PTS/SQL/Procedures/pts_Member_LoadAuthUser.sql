EXEC [dbo].pts_CheckProc 'pts_Member_LoadAuthUser'
GO

CREATE PROCEDURE [dbo].pts_Member_LoadAuthUser
   @AuthUserID int ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @MemberID = me.MemberID
FROM Member AS me (NOLOCK)
WHERE (me.AuthUserID = @AuthUserID)


GO