EXEC [dbo].pts_CheckProc 'pts_BoardUser_Add'
GO

CREATE PROCEDURE [dbo].pts_BoardUser_Add
   @BoardUserID int OUTPUT,
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
INSERT INTO BoardUser (
            AuthUserID , 
            BoardUserName , 
            BoardUserGroup , 
            IsPublicName , 
            IsPublicEmail , 
            Signature

            )
VALUES (
            @AuthUserID ,
            @BoardUserName ,
            @BoardUserGroup ,
            @IsPublicName ,
            @IsPublicEmail ,
            @Signature
            )

SET @mNewID = @@IDENTITY
SET @BoardUserID = @mNewID
GO