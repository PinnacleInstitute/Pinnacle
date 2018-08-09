EXEC [dbo].pts_CheckProc 'pts_Goal_EnumUserMemberList'
GO

CREATE PROCEDURE [dbo].pts_Goal_EnumUserMemberList
   @MemberID int ,
   @Template int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      go.GoalID AS 'ID', 
         go.GoalName AS 'Name'
FROM Goal AS go (NOLOCK)
WHERE (go.MemberID = @MemberID)
 AND (go.Template = @Template)

ORDER BY   go.GoalName

GO