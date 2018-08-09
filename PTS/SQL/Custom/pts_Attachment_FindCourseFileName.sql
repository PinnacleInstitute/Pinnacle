EXEC [dbo].pts_CheckProc 'pts_Attachment_FindCourseFileName'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_FindCourseFileName ( 
   @SearchText nvarchar (100),
   @Bookmark nvarchar (110),
   @MaxRows tinyint OUTPUT,
   @ParentID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(att.FileName, '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) 'BookMark' ,
            att.AttachmentID 'AttachmentID' ,
            att.CompanyID 'CompanyID' ,
            att.ParentID 'ParentID' ,
            att.AuthUserID 'AuthUserID' ,
            att.RefID 'RefID' ,
            att.AttachName 'AttachName' ,
            att.FileName 'FileName' ,
            att.Description + ' (' + le.LessonName + ')' 'Description' ,
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
WHERE ISNULL(att.FileName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(att.FileName, '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) >= @BookMark
AND (le.CourseID = @ParentID)
ORDER BY 'Bookmark'

GO