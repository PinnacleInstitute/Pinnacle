EXEC [dbo].pts_CheckProc 'pts_Affiliate_LoadLogon'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_LoadLogon
   @Logon nvarchar (80) ,
   @AffiliateID int OUTPUT ,
   @AffiliateName nvarchar (60) OUTPUT ,
   @CompanyID int OUTPUT ,
   @NameLast nvarchar (30) OUTPUT ,
   @NameFirst nvarchar (30) OUTPUT ,
   @Phone1 nvarchar (30) OUTPUT ,
   @Email nvarchar (80) OUTPUT
AS

SET NOCOUNT ON

SELECT      @AffiliateID = af.AffiliateID, 
         @AffiliateName = af.AffiliateName, 
         @CompanyID = af.CompanyID, 
         @NameLast = af.NameLast, 
         @NameFirst = af.NameFirst, 
         @Phone1 = af.Phone1, 
         @Email = af.Email
FROM Affiliate AS af (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (af.AuthUserID = au.AuthUserID)
WHERE (au.Logon = @Logon)


GO