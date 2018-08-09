EXEC [dbo].pts_CheckProc 'pts_Prospect_ListReminder'
GO

CREATE PROCEDURE [dbo].pts_Prospect_ListReminder
   @UserID int
AS

SET NOCOUNT ON

SELECT      pr.ProspectID, 
         pr.ProspectName, 
         pr.NextEvent, 
         pr.NextDate, 
         pr.NextTime, 
         me.Email2 AS 'Email2', 
         me.MemberID AS 'MemberID', 
         me.IsMsg AS 'IsMsg'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (pr.MemberID = me.MemberID)
WHERE (pr.RemindDate < GETDATE())
 AND (pr.RemindDate <> 0)


GO