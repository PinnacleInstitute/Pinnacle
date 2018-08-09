EXEC [dbo].pts_CheckProc 'pts_Project_ListCompanyPending'
GO

CREATE PROCEDURE [dbo].pts_Project_ListCompanyPending
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      pj.ProjectID, 
         pj.MemberID, 
         pj.ProjectName, 
         LTRIM(RTRIM(me.NameFirst)) +  ' '  + LTRIM(RTRIM(me.NameLast)) AS 'MemberName', 
         pj.Description, 
         pj.Status, 
         pj.EstStartDate, 
         pj.ActStartDate, 
         pj.VarStartDate, 
         pj.EstEndDate, 
         pj.ActEndDate, 
         pj.VarEndDate, 
         pj.EstCost, 
         pj.TotCost
FROM Project AS pj (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pj.MemberID = me.MemberID)
WHERE (pj.CompanyID = @CompanyID)
 AND (pj.Status = 0)

ORDER BY   pj.ProjectID

GO