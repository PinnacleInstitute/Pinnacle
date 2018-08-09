EXEC [dbo].pts_CheckProc 'pts_Org_LoadLogon'
GO

CREATE PROCEDURE [dbo].pts_Org_LoadLogon
   @Logon nvarchar (80) ,
   @CompanyID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @CompanyID = org.CompanyID
FROM Org AS org (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (org.AuthUserID = au.AuthUserID)
WHERE (au.Logon = @Logon)


GO