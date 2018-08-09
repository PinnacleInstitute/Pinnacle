EXEC [dbo].pts_CheckProc 'pts_BoardUser_Update'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_Update
   @BoardUserID int,
   @AuthUserID int,
   @BoardUserName nvarchar (32),
   @BoardUserGroup int,
   @IsPublicName bit,
   @IsPublicEmail bit,
   @Signature nvarchar (500),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
UPDATE mbu
SET mbu.AuthUserID = @AuthUserID ,
   mbu.BoardUserName = @BoardUserName ,
   mbu.BoardUserGroup = @BoardUserGroup ,
   mbu.IsPublicName = @IsPublicName ,
   mbu.IsPublicEmail = @IsPublicEmail ,
   mbu.Signature = @Signature
FROM BoardUser AS mbu
WHERE (mbu.BoardUserID = @BoardUserID)


GO