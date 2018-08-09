EXEC [dbo].pts_CheckProc 'pts_Member_Delete'
GO

CREATE PROCEDURE [dbo].pts_Member_Delete
   @MemberID int ,
   @UserID int
AS

DECLARE @mAuthUserID int, 
         @mMasterID int

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   04 ,
   @MemberID

EXEC pts_Member_FetchAuthUserID
   @MemberID ,
   @UserID ,
   @mAuthUserID OUTPUT

EXEC pts_AuthUser_Delete
   @mAuthUserID ,
   @UserID

EXEC pts_Member_DeleteMaster
   @MemberID

DELETE me
FROM Member AS me
WHERE (me.MemberID = @MemberID)


EXEC pts_OrgMember_DeleteMembers
   @MemberID ,
   @UserID

GO