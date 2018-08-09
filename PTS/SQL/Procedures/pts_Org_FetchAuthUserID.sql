EXEC [dbo].pts_CheckProc 'pts_Org_FetchAuthUserID'
GO

CREATE PROCEDURE [dbo].pts_Org_FetchAuthUserID
   @OrgID int ,
   @UserID int ,
   @AuthUserID int OUTPUT
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

SELECT      @mAuthUserID = org.AuthUserID
FROM Org AS org (NOLOCK)
WHERE (org.OrgID = @OrgID)


SET @AuthUserID = ISNULL(@mAuthUserID, 0)
GO