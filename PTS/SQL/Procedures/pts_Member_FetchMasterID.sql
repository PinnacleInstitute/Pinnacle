EXEC [dbo].pts_CheckProc 'pts_Member_FetchMasterID'
GO

CREATE PROCEDURE [dbo].pts_Member_FetchMasterID
   @MemberID int ,
   @UserID int ,
   @MasterID int OUTPUT
AS

DECLARE @mMasterID int

SET NOCOUNT ON

SELECT      @mMasterID = me.MasterID
FROM Member AS me (NOLOCK)
WHERE (me.MemberID = @MemberID)


SET @MasterID = ISNULL(@mMasterID, 0)
GO