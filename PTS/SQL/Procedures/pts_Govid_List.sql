EXEC [dbo].pts_CheckProc 'pts_Govid_List'
GO

CREATE PROCEDURE [dbo].pts_Govid_List
   @MemberID int
AS

SET NOCOUNT ON

SELECT      gi.GovidID, 
         gi.GType, 
         gi.GNumber, 
         gi.Issuer, 
         gi.IssueDate, 
         gi.ExpDate
FROM Govid AS gi (NOLOCK)
WHERE (gi.MemberID = @MemberID)

ORDER BY   gi.GType DESC

GO