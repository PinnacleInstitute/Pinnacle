EXEC [dbo].pts_CheckProc 'pts_Member_NewMembers'
GO

CREATE PROCEDURE [dbo].pts_Member_NewMembers
   @CompanyID int
AS

SET NOCOUNT ON

SELECT TOP 20 MemberID, NameFirst + ' ' + Left(NameLast,1) + '.' AS 'Identification'
FROM Member
WHERE CompanyID = @CompanyID AND Status > 0 AND Status < 4
ORDER BY MemberID DESC         

GO