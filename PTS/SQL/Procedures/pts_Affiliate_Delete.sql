EXEC [dbo].pts_CheckProc 'pts_Affiliate_Delete'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_Delete
   @AffiliateID int ,
   @UserID int
AS

DECLARE @mAuthUserID int, 
         @mMemberID int

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   06 ,
   @AffiliateID

EXEC pts_Affiliate_FetchIDs
   @AffiliateID ,
   @UserID ,
   @mAuthUserID OUTPUT ,
   @mMemberID OUTPUT

IF ((@mAuthUserID > 0))
   BEGIN
   EXEC pts_AuthUser_Delete
      @mAuthUserID ,
      @UserID

   END

DELETE af
FROM Affiliate AS af
WHERE (af.AffiliateID = @AffiliateID)


GO