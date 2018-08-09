EXEC [dbo].pts_CheckProc 'pts_BoardUser_FindBoardUserName'
 GO

CREATE PROCEDURE [dbo].pts_BoardUser_FindBoardUserName ( 
   @SearchText nvarchar (32),
   @Bookmark nvarchar (42),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mbu.BoardUserName, '') + dbo.wtfn_FormatNumber(mbu.BoardUserID, 10) 'BookMark' ,
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
WHERE ISNULL(mbu.BoardUserName, '') LIKE @SearchText + '%'
AND ISNULL(mbu.BoardUserName, '') + dbo.wtfn_FormatNumber(mbu.BoardUserID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO