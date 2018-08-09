EXEC [dbo].pts_CheckProc 'pts_Org_GetEmail'
GO

CREATE PROCEDURE [dbo].pts_Org_GetEmail
   @CompanyID int,
   @NameFirst nvarchar (15),
   @Return nvarchar (80) OUTPUT

AS

SET NOCOUNT ON

SELECT TOP 1 @Return = Email FROM Org WHERE CompanyID = @CompanyID AND NameFirst = @NameFirst

GO
