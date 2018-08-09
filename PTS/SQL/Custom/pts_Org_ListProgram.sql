EXEC [dbo].pts_CheckProc 'pts_Org_ListProgram'
GO

--EXEC pts_Org_ListProgram 13, 84

CREATE PROCEDURE [dbo].pts_Org_ListProgram
   @CompanyID int ,
   @MemberID int 
AS

SET NOCOUNT ON

SELECT og.OrgID, og.OrgName
FROM   Org AS og
JOIN   OrgMember AS om ON om.OrgID = og.OrgID AND om.MemberID = @MemberID
WHERE  og.CompanyID = @CompanyID
AND    og.Status = 2
AND    og.IsProgram = 1
AND    og.IsPublic = 0

UNION ALL

SELECT og.OrgID, og.OrgName
FROM   Org AS og (NOLOCK)
WHERE  og.CompanyID = @CompanyID
AND    og.Status = 2
AND    og.IsProgram = 1
AND    og.IsPublic = 1

ORDER BY   og.OrgName

GO

