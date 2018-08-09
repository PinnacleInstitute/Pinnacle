EXEC [dbo].pts_CheckProc 'pts_AuthUser_Add'
GO

CREATE PROCEDURE [dbo].pts_AuthUser_Add
   @Logon nvarchar (80) ,
   @Password nvarchar (30) ,
   @Email nvarchar (80) ,
   @NameLast nvarchar (30) ,
   @NameFirst nvarchar (30) ,
   @UserGroup int ,
   @UserStatus int ,
   @UserID int ,
   @AuthUserID int OUTPUT
AS

DECLARE @mNow datetime, 
         @mNewID int, 
         @mLogon nvarchar (80), 
         @mPassword nvarchar (30)

SET NOCOUNT ON

SET @mNow = GETDATE()
IF ((@UserGroup > 0))
   BEGIN
   EXEC pts_System_GetLogon
      @mLogon OUTPUT ,
      @Logon

   IF ((@Password = '')   )
      BEGIN
      EXEC pts_System_GetPassword
         @mPassword OUTPUT

      END

   IF ((@Password <> '')   )
      BEGIN
      SET @mPassword = @Password
      END

   INSERT INTO AuthUser (
               Logon  , 
               Password  , 
               Email  , 
               NameLast  , 
               NameFirst  , 
               UserGroup  , 
               UserStatus  , 
               CreateDate  , 
               CreateID  , 
               ChangeDate  , 
               ChangeID 

               )
   VALUES (
         @mLogon  , 
         @mPassword  , 
         @Email  , 
         @NameLast  , 
         @NameFirst  , 
         @UserGroup  , 
         @UserStatus  , 
         @mNow  , 
         @UserID  , 
         @mNow  , 
         @UserID 
               )

   SET @mNewID = @@IDENTITY
   END

SET @AuthUserID = ISNULL(@mNewID, 0)
GO