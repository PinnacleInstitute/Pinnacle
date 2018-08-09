EXEC [dbo].pts_CheckProc 'pts_Member_ListOrg'
GO

CREATE PROCEDURE [dbo].pts_Member_ListOrg
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      me.MemberID, 
         me.CompanyName, 
         me.Email, 
         me.EnrollDate, 
         me.Reference
FROM Member AS me (NOLOCK)
WHERE (me.CompanyID = @CompanyID)


GO