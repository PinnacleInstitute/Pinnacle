EXEC [dbo].pts_CheckProc 'pts_Attachment_FindCompanyAttachDate'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_FindCompanyAttachDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @ParentID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), att.AttachDate, 112), '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) 'BookMark' ,
            att.AttachmentID 'AttachmentID' ,
            att.CompanyID 'CompanyID' ,
            att.ParentID 'ParentID' ,
            att.AuthUserID 'AuthUserID' ,
            att.RefID 'RefID' ,
            att.AttachName 'AttachName' ,
            att.FileName 'FileName' ,
            att.Description + ' (' + co.CourseName + ' - ' + le.LessonName + ')' 'Description' ,
            att.ParentType 'ParentType' ,
            att.AttachSize 'AttachSize' ,
            att.AttachDate 'AttachDate' ,
            att.ExpireDate 'ExpireDate' ,
            att.Status 'Status' ,
            att.IsLink 'IsLink' ,
            att.Secure 'Secure' ,
            att.Score 'Score'
FROM Attachment AS att (NOLOCK)
LEFT OUTER JOIN Lesson AS le ON att.ParentType = 23 AND att.ParentID = le.LessonID 
LEFT OUTER JOIN Course AS co ON le.CourseID = co.CourseID 
WHERE ISNULL(CONVERT(nvarchar(10), att.AttachDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), att.AttachDate, 112), '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) <= @BookMark
AND (att.CompanyID = @ParentID)
ORDER BY 'Bookmark' DESC

GO