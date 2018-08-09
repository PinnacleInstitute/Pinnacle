EXEC [dbo].pts_CheckProc 'pts_Attachment_SearchDate'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_SearchDate ( 
      @SearchText nvarchar (20),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int,
      @Secure int
      )
AS

SET            NOCOUNT ON

DECLARE @Now datetime
SET @Now = GETDATE()

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''

SELECT TOP 21
   ISNULL(CONVERT(nvarchar(10), att.AttachDate, 112), '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) 'BookMark' ,
	att.AttachmentID,
	att.ParentType,
	att.ParentID,
	att.AttachName,
	att.FileName,
   Left(att.Description,200) 'Description', 
	att.AttachSize,
	att.AttachDate,
	att.IsLink,
	att.Secure
FROM Attachment AS att
WHERE ISNULL(CONVERT(NVARCHAR(10), att.AttachDate, 112), '') >= @SearchText
AND ISNULL(CONVERT(NVARCHAR(10), att.AttachDate, 112), '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) <= @BookMark
AND att.CompanyID = @CompanyID
AND att.ParentType = 28
AND att.Secure <= @Secure
AND (att.ExpireDate = 0 OR ExpireDate > @Now)
AND att.Status = 1
ORDER BY 'Bookmark' DESC 

GO