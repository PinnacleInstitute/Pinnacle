EXEC [dbo].pts_CheckProc 'pts_Project_EnumUserMember'
GO

CREATE PROCEDURE [dbo].pts_Project_EnumUserMember
   @ProjectID int ,
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pj.ProjectID AS 'ID', 
         pj.ProjectName + ' (#' + CAST(pj.ProjectID AS VARCHAR(10)) + ')' AS 'Name'
FROM Project AS pj (NOLOCK)
WHERE (pj.MemberID = @MemberID)
 AND (pj.ProjectID <> @ProjectID)
 AND (pj.Status < 2)

ORDER BY   pj.ProjectName

GO