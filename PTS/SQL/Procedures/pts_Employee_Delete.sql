EXEC [dbo].pts_CheckProc 'pts_Employee_Delete'
GO

CREATE PROCEDURE [dbo].pts_Employee_Delete
   @EmployeeID int ,
   @UserID int
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

EXEC pts_Employee_FetchAuthUserID
   @EmployeeID ,
   @UserID ,
   @mAuthUserID OUTPUT

EXEC pts_AuthUser_Delete
   @mAuthUserID ,
   @UserID

DELETE em
FROM Employee AS em
WHERE (em.EmployeeID = @EmployeeID)


GO