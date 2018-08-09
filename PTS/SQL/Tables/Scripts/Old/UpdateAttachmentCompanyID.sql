
SET NOCOUNT ON

DECLARE	@ID int, @AttachmentID int, @CompanyID int, @ParentType int, @ParentID int

DECLARE Attachment_cursor CURSOR FOR 
SELECT  AttachmentID, ParentType, ParentID
FROM Attachment

OPEN Attachment_cursor

FETCH NEXT FROM Attachment_cursor INTO @AttachmentID, @ParentType, @ParentID

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Attachment_GetCompanyID @ParentType, @ParentID, @ID OUTPUT
	UPDATE Attachment SET CompanyID = @ID WHERE AttachmentID = @AttachmentID
	
	FETCH NEXT FROM Attachment_cursor INTO @AttachmentID, @ParentType, @ParentID
END

CLOSE Attachment_cursor
DEALLOCATE Attachment_cursor

