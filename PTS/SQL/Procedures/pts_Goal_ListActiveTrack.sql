EXEC [dbo].pts_CheckProc 'pts_Goal_ListActiveTrack'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListActiveTrack
   @MemberID int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.GoalName
FROM Goal AS go (NOLOCK)
WHERE (go.MemberID = @MemberID)
 AND (go.Status = 2)
 AND (go.ParentID = 0)
 AND (go.Template = 0)

ORDER BY   go.GoalName

GO