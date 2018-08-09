EXEC [dbo].pts_CheckProc 'pts_Project_ListCompanyCompleted'
GO

CREATE PROCEDURE [dbo].pts_Project_ListCompanyCompleted
   @CompanyID int ,
   @FromDate datetime ,
   @ToDate datetime
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
 AND (pj.ActEndDate >= @FromDate)
 AND (pj.ActEndDate <= @ToDate)
 AND (pj.Status = 2)

ORDER BY   pj.ActEndDate

GO