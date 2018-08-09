EXEC [dbo].pts_CheckProc 'pts_Downline_GetCounts'
GO

CREATE PROCEDURE [dbo].pts_Downline_GetCounts
   @Line int ,
   @ParentID int ,
   @Dec int OUTPUT ,
   @Old int OUTPUT
AS

SET NOCOUNT ON

SELECT @Dec = COUNT(*) 
FROM Downline AS dl
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE dl.Line = @Line 
AND dl.ParentID = @ParentID
AND me.Status = 1

SELECT @Old = COUNT(*) 
FROM Downline AS dl
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE dl.Line = @Line 
AND dl.ParentID = @ParentID
AND me.Status >= 1 AND me.Status <= 4 

GO