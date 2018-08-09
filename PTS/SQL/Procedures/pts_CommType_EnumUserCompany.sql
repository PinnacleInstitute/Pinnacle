EXEC [dbo].pts_CheckProc 'pts_CommType_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_CommType_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      ct.CommTypeID AS 'ID', 
         ct.CommTypeName AS 'Name'
FROM CommType AS ct (NOLOCK)
WHERE (ct.CompanyID = @CompanyID)

ORDER BY   ct.CommTypeNo

GO