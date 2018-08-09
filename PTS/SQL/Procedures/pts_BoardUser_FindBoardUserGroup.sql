EXEC [dbo].pts_CheckProc 'pts_BoardUser_FindBoardUserGroup'
 GO

CREATE PROCEDURE [dbo].pts_BoardUser_FindBoardUserGroup ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), mbu.BoardUserGroup), '') + dbo.wtfn_FormatNumber(mbu.BoardUserID, 10) 'BookMark' ,
            mbu.BoardUserID 'BoardUserID' ,
            mbu.AuthUserID 'AuthUserID' ,
            au.NameFirst 'AuthUserNameLast' ,
            au.NameLast 'AuthUserNameFirst' ,
            LTRIM(RTRIM(au.NameLast)) +  ' '  + LTRIM(RTRIM(au.NameFirst)) 'AuthUserName' ,
            au.Email 'Email' ,
            au.Password 'BoardUserPassword' ,
            mbu.BoardUserName 'BoardUserName' ,
            mbu.BoardUserGroup 'BoardUserGroup' ,
            mbu.IsPublicName 'IsPublicName' ,
            mbu.IsPublicEmail 'IsPublicEmail' ,
            mbu.Signature 'Signature'
FROM BoardUser AS mbu (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mbu.AuthUserID = au.AuthUserID)
WHERE ISNULL(CONVERT(nvarchar(10), mbu.BoardUserGroup), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), mbu.BoardUserGroup), '') + dbo.wtfn_FormatNumber(mbu.BoardUserID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO