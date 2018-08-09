EXEC [dbo].pts_CheckProc 'pts_Employee_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Employee_Fetch ( 
   @EmployeeID int,
   @AuthUserID int OUTPUT,
   @MemberID int OUTPUT,
   @UserGroup int OUTPUT,
   @UserStatus int OUTPUT,
   @NameLast nvarchar (15) OUTPUT,
   @NameFirst nvarchar (15) OUTPUT,
   @EmployeeName nvarchar (32) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @Phone nvarchar (30) OUTPUT,
   @Mobile nvarchar (30) OUTPUT,
   @Title nvarchar (20) OUTPUT,
   @Status int OUTPUT,
   @Notes varchar (2000) OUTPUT,
   @Security varchar (1000) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @AuthUserID = em.AuthUserID ,
   @MemberID = em.MemberID ,
   @UserGroup = au.UserGroup ,
   @UserStatus = au.UserStatus ,
   @NameLast = em.NameLast ,
   @NameFirst = em.NameFirst ,
   @EmployeeName = LTRIM(RTRIM(em.NameFirst)) +  ' '  + LTRIM(RTRIM(em.NameLast)) +  ''  ,
   @Email = em.Email ,
   @Street = em.Street ,
   @Unit = em.Unit ,
   @City = em.City ,
   @State = em.State ,
   @Zip = em.Zip ,
   @Country = em.Country ,
   @Phone = em.Phone ,
   @Mobile = em.Mobile ,
   @Title = em.Title ,
   @Status = em.Status ,
   @Notes = em.Notes ,
   @Security = em.Security
FROM Employee AS em (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (em.AuthUserID = au.AuthUserID)
WHERE em.EmployeeID = @EmployeeID

GO