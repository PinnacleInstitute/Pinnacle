EXEC [dbo].pts_CheckProc 'pts_Goal_ListCompanyTrack'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListCompanyTrack
   @CompanyID int ,
   @Template int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.GoalName
FROM Goal AS go (NOLOCK)
WHERE (go.CompanyID = @CompanyID)
 AND (go.Template = @Template)

ORDER BY   go.GoalName

GO