EXEC [dbo].pts_CheckProc 'pts_Employee_Update'
GO

CREATE PROCEDURE [dbo].pts_Employee_Update
   @EmployeeID int,
   @AuthUserID int,
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
         @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()
IF ((@AuthUserID > 0) AND (@UserGroup = 0))
   BEGIN
   EXEC pts_AuthUser_Delete
      @AuthUserID ,
      @UserID

   SET @AuthUserID = 0
   END

IF ((@AuthUserID > 0) AND (@UserGroup > 0))
   BEGIN
   EXEC pts_AuthUser_Update
      @AuthUserID ,
      @Email ,
      @NameLast ,
      @NameFirst ,
      @UserGroup ,
      @UserStatus ,
      @UserID

   END

IF ((@AuthUserID = 0) AND (@UserGroup > 0))
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
      @mNewID OUTPUT

   SET @AuthUserID = ISNULL(@mNewID, 0)
   END

UPDATE em
SET em.AuthUserID = @AuthUserID ,
   em.MemberID = @MemberID ,
   em.NameLast = @NameLast ,
   em.NameFirst = @NameFirst ,
   em.Email = @Email ,
   em.Street = @Street ,
   em.Unit = @Unit ,
   em.City = @City ,
   em.State = @State ,
   em.Zip = @Zip ,
   em.Country = @Country ,
   em.Phone = @Phone ,
   em.Mobile = @Mobile ,
   em.Title = @Title ,
   em.Status = @Status ,
   em.Notes = @Notes ,
   em.Security = @Security
FROM Employee AS em
WHERE (em.EmployeeID = @EmployeeID)


GO