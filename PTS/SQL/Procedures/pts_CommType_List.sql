EXEC [dbo].pts_CheckProc 'pts_CommType_List'
GO

CREATE PROCEDURE [dbo].pts_CommType_List
   @CompanyID int
AS

SET NOCOUNT ON

SELECT      ct.CommTypeID, 
         ct.CommTypeName, 
         ct.CommTypeNo
FROM CommType AS ct (NOLOCK)
WHERE (ct.CompanyID = @CompanyID)

ORDER BY   ct.CommTypeNo

GO