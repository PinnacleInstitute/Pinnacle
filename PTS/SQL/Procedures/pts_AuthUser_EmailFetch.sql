EXEC [dbo].pts_CheckProc 'pts_AuthUser_EmailFetch'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_EmailFetch
   @Email nvarchar (80) ,
   @AuthUserID int OUTPUT ,
   @Logon nvarchar (80) OUTPUT ,
   @Password nvarchar (30) OUTPUT
AS

SET NOCOUNT ON

SELECT      @AuthUserID = au.AuthUserID, 
         @Logon = au.Logon, 
         @Password = au.Password
FROM AuthUser AS au (NOLOCK)
LEFT OUTER JOIN Trainer AS tr (NOLOCK) ON (au.AuthUserID = tr.AuthUserID)
LEFT OUTER JOIN Employee AS em (NOLOCK) ON (au.AuthUserID = em.AuthUserID)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (au.AuthUserID = me.AuthUserID)
LEFT OUTER JOIN Org AS org (NOLOCK) ON (au.AuthUserID = org.AuthUserID)
LEFT OUTER JOIN Affiliate AS af (NOLOCK) ON (au.AuthUserID = af.AuthUserID)
WHERE (au.Email = @Email)


GO