EXEC [dbo].pts_CheckProc 'pts_Goal_ListTemplate'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListTemplate
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.GoalName
FROM Goal AS go (NOLOCK)
WHERE (go.CompanyID = @CompanyID)

ORDER BY   go.GoalName

GO