EXEC [dbo].pts_CheckProc 'pts_Prospect_BoardMember'
GO

CREATE PROCEDURE [dbo].pts_Prospect_BoardMember
   @MemberID int ,
   @SalesCampaignID int
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.MemberID, 
         pr.ProspectName, 
         me.CompanyName AS 'MemberName', 
         pr.Status, 
         pr.Potential, 
         pr.NextDate, 
         pr.NextTime, 
         pr.NextEvent
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
LEFT OUTER JOIN SalesStep AS sls (NOLOCK) ON (pr.Status = sls.SalesStepID)
WHERE (pr.MemberID = @MemberID)
 AND (pr.SalesCampaignID = @SalesCampaignID)
 AND (sls.IsBoard <> 0)
 AND (pr.Status > 0)

ORDER BY   pr.NextDate , pr.NextTime

GO