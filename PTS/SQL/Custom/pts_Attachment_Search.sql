EXEC [dbo].pts_CheckProc 'pts_Attachment_Search'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_Search ( 
      @SearchText nvarchar (200),
      @Bookmark nvarchar (14),
      @MaxRows tinyint OUTPUT,
      @CompanyID int,
      @Secure int
      )
AS

SET NOCOUNT ON

DECLARE @Now datetime
SET @Now = GETDATE()

SET @MaxRows = 20

IF @Bookmark = '' 
	SET @Bookmark = '9999'

SELECT TOP 21
	dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(att.AttachmentID, 10) 'BookMark' ,
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
INNER JOIN CONTAINSTABLE(AttachmentFT,*, @SearchText, 1000 ) AS K ON att.AttachmentID = K.[KEY]
WHERE dbo.wtfn_FormatNumber(K.[RANK], 4) + dbo.wtfn_FormatNumber(att.AttachmentID, 10) <= @Bookmark
AND att.CompanyID = @CompanyID
AND att.Secure <= @Secure
AND (att.ExpireDate = 0 OR ExpireDate > @Now)
AND att.Status = 1
ORDER BY 'Bookmark' desc 

GO