EXEC [dbo].pts_CheckProc 'pts_Downline_GetCount'
GO

CREATE PROCEDURE [dbo].pts_Downline_GetCount
   @Line int ,
   @ParentID int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

SELECT @Count = COUNT(*) 
FROM Downline AS dl
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE dl.Line = @Line 
AND dl.ParentID = @ParentID
AND me.Status >= 1
AND me.Status <= 4

GO