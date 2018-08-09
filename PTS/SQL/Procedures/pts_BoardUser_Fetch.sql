EXEC [dbo].pts_CheckProc 'pts_BoardUser_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_BoardUser_Fetch ( 
   @BoardUserID int,
   @AuthUserID int OUTPUT,
   @AuthUserNameLast nvarchar (30) OUTPUT,
   @AuthUserNameFirst nvarchar (30) OUTPUT,
   @AuthUserName nvarchar (62) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @BoardUserPassword nvarchar (30) OUTPUT,
   @BoardUserName nvarchar (32) OUTPUT,
   @BoardUserGroup int OUTPUT,
   @IsPublicName bit OUTPUT,
   @IsPublicEmail bit OUTPUT,
   @Signature nvarchar (500) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = mbu.AuthUserID ,
   @AuthUserNameLast = au.NameFirst ,
   @AuthUserNameFirst = au.NameLast ,
   @AuthUserName = LTRIM(RTRIM(au.NameLast)) +  ' '  + LTRIM(RTRIM(au.NameFirst)) ,
   @Email = au.Email ,
   @BoardUserPassword = au.Password ,
   @BoardUserName = mbu.BoardUserName ,
   @BoardUserGroup = mbu.BoardUserGroup ,
   @IsPublicName = mbu.IsPublicName ,
   @IsPublicEmail = mbu.IsPublicEmail ,
   @Signature = mbu.Signature
FROM BoardUser AS mbu (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (mbu.AuthUserID = au.AuthUserID)
WHERE mbu.BoardUserID = @BoardUserID

GO