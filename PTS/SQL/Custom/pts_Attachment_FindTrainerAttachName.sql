EXEC [dbo].pts_CheckProc 'pts_Attachment_FindTrainerAttachName'
 GO

CREATE PROCEDURE [dbo].pts_Attachment_FindTrainerAttachName ( 
   @SearchText nvarchar (60),
   @Bookmark nvarchar (70),
   @MaxRows tinyint OUTPUT,
   @ParentID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(att.AttachName, '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) 'BookMark' ,
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
WHERE ISNULL(att.AttachName, '') LIKE '%' + @SearchText + '%'
AND ISNULL(att.AttachName, '') + dbo.wtfn_FormatNumber(att.AttachmentID, 10) >= @BookMark
AND (co.TrainerID = @ParentID)
ORDER BY 'Bookmark'

GO