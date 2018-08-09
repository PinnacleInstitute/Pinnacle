EXEC [dbo].pts_CheckProc 'pts_Employee_FetchAuthUserID'
GO

CREATE PROCEDURE [dbo].pts_Employee_FetchAuthUserID
   @EmployeeID int ,
   @UserID int ,
   @AuthUserID int OUTPUT
AS

DECLARE @mAuthUserID int

SET NOCOUNT ON

SELECT      @mAuthUserID = em.AuthUserID
FROM Employee AS em (NOLOCK)
WHERE (em.EmployeeID = @EmployeeID)


SET @AuthUserID = ISNULL(@mAuthUserID, 0)
GO