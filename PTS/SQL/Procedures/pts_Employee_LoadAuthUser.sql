EXEC [dbo].pts_CheckProc 'pts_Employee_LoadAuthUser'
GO

CREATE PROCEDURE [dbo].pts_Employee_LoadAuthUser
   @AuthUserID int ,
   @EmployeeID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @EmployeeID = em.EmployeeID
FROM Employee AS em (NOLOCK)
WHERE (em.AuthUserID = @AuthUserID)


GO