EXEC [dbo].pts_CheckProc 'pts_Downline_Children'
GO

CREATE PROCEDURE [dbo].pts_Downline_Children
   @Line int ,
   @ParentID int
AS

SET NOCOUNT ON

SELECT dl.DownlineID , 
	   dl.ChildID ,
       me.NameFirst + ' ' + me.NameLast 'ChildName' , 
       me.Status , 
       me.Title
FROM Downline AS dl
JOIN Member AS me ON dl.ChildID = me.MemberID
WHERE dl.Line = @Line AND dl.ParentID = @ParentID
ORDER BY dl.Position

GO