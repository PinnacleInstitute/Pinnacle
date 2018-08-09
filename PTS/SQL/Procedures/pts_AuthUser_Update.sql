EXEC [dbo].pts_CheckProc 'pts_AuthUser_Update'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_Update
   @AuthUserID int ,
   @Email nvarchar (80) ,
   @NameLast nvarchar (30) ,
   @NameFirst nvarchar (30) ,
   @UserGroup int ,
   @UserStatus int ,
   @UserID int
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE au
SET au.Email = @Email , 
   au.NameLast = @NameLast , 
   au.NameFirst = @NameFirst , 
   au.UserGroup = @UserGroup , 
   au.UserStatus = @UserStatus , 
   au.ChangeDate = @mNow , 
   au.ChangeID = @UserID 
FROM AuthUser AS au
WHERE (au.AuthUserID = @AuthUserID)


GO