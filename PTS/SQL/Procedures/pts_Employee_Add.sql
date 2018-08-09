EXEC [dbo].pts_CheckProc 'pts_Employee_Add'
GO

CREATE PROCEDURE [dbo].pts_Employee_Add
   @EmployeeID int OUTPUT,
   @AuthUserID int OUTPUT,
   @MemberID int,
   @UserGroup int,
   @UserStatus int,
   @NameLast nvarchar (15),
   @NameFirst nvarchar (15),
   @Email nvarchar (80),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @Phone nvarchar (30),
   @Mobile nvarchar (30),
   @Title nvarchar (20),
   @Status int,
   @Notes varchar (2000),
   @Security varchar (1000),
   @UserID int
AS

DECLARE @mNow datetime, 
         @mNewID int, 
         @mAuthUserID int

SET NOCOUNT ON

SET @mNow = GETDATE()
SET @mAuthUserID = 0
IF ((@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Add
      @Email ,
      '' ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID ,
      @mAuthUserID OUTPUT

   SET @AuthUserID = ISNULL(@mAuthUserID, 0)
   END

INSERT INTO Employee (
            AuthUserID , 
            MemberID , 
            NameLast , 
            NameFirst , 
            Email , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            Phone , 
            Mobile , 
            Title , 
            Status , 
            Notes , 
            Security

            )
VALUES (
            @mAuthUserID ,
            @MemberID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @Phone ,
            @Mobile ,
            @Title ,
            @Status ,
            @Notes ,
            @Security
            )

SET @mNewID = @@IDENTITY
SET @EmployeeID = @mNewID
SET @AuthUserID = @mAuthUserID
GO