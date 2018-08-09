EXEC [dbo].pts_CheckProc 'pts_LeadAd_ListGroup'
GO

CREATE PROCEDURE [dbo].pts_LeadAd_ListGroup
   @GroupID int
AS

SET NOCOUNT ON

SELECT      la.LeadAdID, 
         la.LeadAdName, 
         la.Target, 
         la.Status, 
         la.Link, 
         la.Image
FROM LeadAd AS la (NOLOCK)
WHERE (la.GroupID = @GroupID)
 AND ((la.Status = 2)
 OR (la.Status = 4))

ORDER BY   la.Seq , la.LeadAdName

GO