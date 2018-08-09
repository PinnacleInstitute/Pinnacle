EXEC [dbo].pts_CheckProc 'pts_Goal_ListMemberTrack'
GO

CREATE PROCEDURE [dbo].pts_Goal_ListMemberTrack
   @MemberID int ,
   @Template int
AS

SET NOCOUNT ON

SELECT      go.GoalID, 
         go.GoalName
FROM Goal AS go (NOLOCK)
WHERE (go.MemberID = @MemberID)
 AND (go.Template = @Template)

ORDER BY   go.GoalName

GO