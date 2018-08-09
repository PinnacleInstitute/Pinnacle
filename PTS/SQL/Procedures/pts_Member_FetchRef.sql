EXEC [dbo].pts_CheckProc 'pts_Member_FetchRef'
GO

CREATE PROCEDURE [dbo].pts_Member_FetchRef
   @CompanyID int ,
   @Reference nvarchar (15) ,
   @MemberID int OUTPUT ,
   @AuthUserID int OUTPUT
AS

DECLARE @mMemberID int, 
         @mAuthUserID int

SET NOCOUNT ON

SELECT      @mMemberID = me.MemberID, 
         @mAuthUserID = me.AuthUserID
FROM Member AS me (NOLOCK)
WHERE (me.CompanyID = @CompanyID)
 AND (me.Reference = @Reference)


SET @MemberID = ISNULL(@mMemberID, 0)
SET @AuthUserID = ISNULL(@mAuthUserID, 0)
GO