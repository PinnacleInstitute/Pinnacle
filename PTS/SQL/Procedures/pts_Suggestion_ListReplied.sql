EXEC [dbo].pts_CheckProc 'pts_Suggestion_ListReplied'
GO

CREATE PROCEDURE [dbo].pts_Suggestion_ListReplied
   @MemberID int
AS

SET NOCOUNT ON

SELECT      sg.SuggestionID, 
         sg.SuggestionDate, 
         sg.ChangeDate, 
         sg.Subject, 
         sg.Description, 
         sg.Response, 
         og.OrgName AS 'OrgName'
FROM Suggestion AS sg (NOLOCK)
LEFT OUTER JOIN Org AS og (NOLOCK) ON (sg.OrgID = og.OrgID)
WHERE (sg.MemberID = @MemberID)
 AND (sg.Status > 1)


GO