EXEC [dbo].pts_CheckProc 'pts_Attachment_CountParent'
GO

CREATE PROCEDURE [dbo].pts_Attachment_CountParent
   @ParentType int,
   @ParentID int,
   @Result int OUTPUT
AS

SELECT @Result = COUNT(*) FROM Attachment WHERE ParentType = @ParentType AND ParentID = @ParentID

GO
