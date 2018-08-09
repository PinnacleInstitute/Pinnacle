EXEC [dbo].pts_CheckProc 'pts_Company_GetSubnet'
GO

CREATE PROCEDURE [dbo].pts_Company_GetSubnet
   @Subnet nvarchar(20),   
   @CompanyID int OUTPUT
AS

SET NOCOUNT ON

SELECT @CompanyID = CompanyID
FROM Company 
WHERE Subnet = @Subnet

GO