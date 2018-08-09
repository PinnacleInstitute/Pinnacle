EXEC [dbo].pts_CheckProc 'pts_Org_LoadAuthUser'
GO

CREATE PROCEDURE [dbo].pts_Org_LoadAuthUser
   @AuthUserID int ,
   @OrgID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @OrgID = org.OrgID
FROM Org AS org (NOLOCK)
WHERE (org.AuthUserID = @AuthUserID)


GO