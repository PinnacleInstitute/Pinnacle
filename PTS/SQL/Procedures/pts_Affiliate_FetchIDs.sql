EXEC [dbo].pts_CheckProc 'pts_Affiliate_FetchIDs'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_FetchIDs
   @AffiliateID int ,
   @UserID int ,
   @AuthUserID int OUTPUT ,
   @MemberID int OUTPUT
AS

DECLARE @mAuthUserID int, 
         @mMemberID int

SET NOCOUNT ON

SELECT      @mAuthUserID = af.AuthUserID, 
         @mMemberID = af.MemberID
FROM Affiliate AS af (NOLOCK)
WHERE (af.AffiliateID = @AffiliateID)


SET @AuthUserID = ISNULL(@mAuthUserID, 0)
SET @MemberID = ISNULL(@mMemberID, 0)
GO