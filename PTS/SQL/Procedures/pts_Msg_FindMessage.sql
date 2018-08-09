EXEC [dbo].pts_CheckProc 'pts_Msg_FindMessage'
 GO

CREATE PROCEDURE [dbo].pts_Msg_FindMessage ( 
   @SearchText nvarchar (2000),
   @Bookmark nvarchar (2010),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @FromDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mg.Message, '') + dbo.wtfn_FormatNumber(mg.MsgID, 10) 'BookMark' ,
            mg.MsgID 'MsgID' ,
            mg.OwnerType 'OwnerType' ,
            mg.OwnerID 'OwnerID' ,
            mg.AuthUserID 'AuthUserID' ,
            au.NameLast 'NameLast' ,
            au.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) 'UserName' ,
            mg.MsgDate 'MsgDate' ,
            mg.Subject 'Subject' ,
            mg.Message 'Message' ,
            mg.Status 'Status'
FROM Msg AS mg (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mg.AuthUserID = au.AuthUserID)
WHERE ISNULL(mg.Message, '') LIKE '%' + @SearchText + '%'
AND ISNULL(mg.Message, '') + dbo.wtfn_FormatNumber(mg.MsgID, 10) >= @BookMark
AND         (mg.OwnerType = @OwnerType)
AND         (mg.OwnerID = @OwnerID)
AND         (mg.MsgDate >= @FromDate)
AND         (mg.MsgDate <= @ToDate)
ORDER BY 'Bookmark'

GO