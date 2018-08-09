EXEC [dbo].pts_CheckProc 'pts_MemberAssess_Delete'
GO

CREATE PROCEDURE [dbo].pts_MemberAssess_Delete
   @MemberAssessID int,
   @UserID int
AS

SET NOCOUNT ON

EXEC pts_Shortcut_DeleteItem
   34 ,
   @MemberAssessID

DELETE ma
FROM MemberAssess AS ma
WHERE (ma.MemberAssessID = @MemberAssessID)


GO