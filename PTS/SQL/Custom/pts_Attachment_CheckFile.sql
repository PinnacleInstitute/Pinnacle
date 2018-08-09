EXEC [dbo].pts_CheckProc 'pts_Attachment_CheckFile'
GO

CREATE PROCEDURE [dbo].pts_Attachment_CheckFile
   @ParentType int,
   @ParentID int,
   @FileName nvarchar (100),
   @Result int OUTPUT
AS

SET @Result = 0
--Search for the exact filename in the ParentType and ParentID 
SELECT TOP 1 @Result = AttachmentID FROM Attachment 
WHERE ParentType = @ParentType AND ParentID = @ParentID AND Filename = @Filename

--If not found and the filename is not a URL
If @Result = 0 AND @FileName NOT LIKE 'http%'
BEGIN
--	-- Search for the attachment filename containing the ParentType, ParentID and FileName
	SELECT TOP 1 @Result = AttachmentID FROM Attachment 
	WHERE ParentType = @ParentType AND ParentID = @ParentID
	AND Filename Like '%' + CAST(@ParentType AS VARCHAR(10)) + '%'
	AND Filename Like '%' + CAST(@ParentID AS VARCHAR(10)) + '%'
	AND Filename Like '%' + @Filename
END

GO
