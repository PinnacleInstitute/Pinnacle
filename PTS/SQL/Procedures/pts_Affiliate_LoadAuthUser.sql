EXEC [dbo].pts_CheckProc 'pts_Affiliate_LoadAuthUser'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_LoadAuthUser
   @AuthUserID int ,
   @AffiliateID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @AffiliateID = af.AffiliateID
FROM Affiliate AS af (NOLOCK)
WHERE (af.AuthUserID = @AuthUserID)


GO