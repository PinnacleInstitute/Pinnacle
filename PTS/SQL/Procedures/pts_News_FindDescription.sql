EXEC [dbo].pts_CheckProc 'pts_News_FindDescription'
 GO

CREATE PROCEDURE [dbo].pts_News_FindDescription ( 
   @SearchText nvarchar (1000),
   @Bookmark nvarchar (1010),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(nw.Description, '') + dbo.wtfn_FormatNumber(nw.NewsID, 10) 'BookMark' ,
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
WHERE ISNULL(nw.Description, '') LIKE '%' + @SearchText + '%'
AND ISNULL(nw.Description, '') + dbo.wtfn_FormatNumber(nw.NewsID, 10) >= @BookMark
AND         (nw.CompanyID = @CompanyID)
ORDER BY 'Bookmark'

GO