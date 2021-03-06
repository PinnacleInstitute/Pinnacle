EXEC [dbo].pts_CheckProc 'pts_News_FindTopicActiveDate'
 GO

CREATE PROCEDURE [dbo].pts_News_FindTopicActiveDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @NewsTopicID int,
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
            ISNULL(CONVERT(nvarchar(10), nw.ActiveDate, 112), '') + dbo.wtfn_FormatNumber(nw.NewsID, 10) 'BookMark' ,
            nw.NewsID 'NewsID' ,
            nw.CompanyID 'CompanyID' ,
            nw.AuthUserID 'AuthUserID' ,
            nw.NewsTopicID 'NewsTopicID' ,
            au.NameLast 'NameLast' ,
            au.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) 'UserName' ,
            nwt.NewsTopicName 'NewsTopicName' ,
            nw.Title 'Title' ,
            nw.Description 'Description' ,
            nw.CreateDate 'CreateDate' ,
            nw.ActiveDate 'ActiveDate' ,
            nw.Image 'Image' ,
            nw.Tags 'Tags' ,
            nw.Status 'Status' ,
            nw.Seq 'Seq' ,
            nw.LeadMain 'LeadMain' ,
            nw.LeadTopic 'LeadTopic' ,
            nw.IsBreaking 'IsBreaking' ,
            nw.IsBreaking2 'IsBreaking2' ,
            nw.IsStrategic 'IsStrategic' ,
            nw.IsShare 'IsShare' ,
            nw.IsEditorial 'IsEditorial' ,
            nw.UserRole 'UserRole'
FROM News AS nw (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
WHERE ISNULL(CONVERT(nvarchar(10), nw.ActiveDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), nw.ActiveDate, 112), '') + dbo.wtfn_FormatNumber(nw.NewsID, 10) <= @BookMark
AND         (nw.CompanyID = @CompanyID)
AND         (nw.NewsTopicID = @NewsTopicID)
ORDER BY 'Bookmark' DESC

GO