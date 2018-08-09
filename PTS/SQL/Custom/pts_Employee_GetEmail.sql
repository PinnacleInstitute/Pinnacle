EXEC [dbo].pts_CheckProc 'pts_Employee_GetEmail'
GO

CREATE PROCEDURE [dbo].pts_Employee_GetEmail
   @NameFirst nvarchar (15),
   @Return nvarchar (80) OUTPUT

AS

SET NOCOUNT ON

SELECT TOP 1 @Return = Email FROM Employee WHERE NameFirst = @NameFirst

GO
