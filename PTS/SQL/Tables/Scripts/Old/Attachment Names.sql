DECLARE @AttachmentID int, @FileName varchar(100), pos int

DECLARE Attachment_Name CURSOR LOCAL STATIC FOR 
SELECT AttachmentID, [Filename]
FROM Attachment WHERE [Filename]like '%F&G%'

OPEN Attachment_Name
FETCH NEXT FROM Attachment_Name INTO @AttachmentID, @FileName 

WHILE @@FETCH_STATUS = 0
BEGIN
print @filename
	SET pos = CHARINDEX('F&G', @FileName)
	If pos = 1
		SET @FileName = 'FnG' + SUBSTRING(@FileName, 4, 100)
	Else
		SET @FileName = SUBSTRING(@FileName, 1, pos-1) + 'FnG' + SUBSTRING(@FileName, pos+4, 100)

print @filename
	FETCH NEXT FROM Attachment_Name INTO @AttachmentID, @FileName 
END
CLOSE Attachment_Name
DEALLOCATE Attachment_Name

