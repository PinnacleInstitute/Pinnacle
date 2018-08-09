EXEC [dbo].pts_CheckProc 'pts_ProductType_EnumUserCompanyPublic'
GO

CREATE PROCEDURE [dbo].pts_ProductType_EnumUserCompanyPublic
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pdt.ProductTypeID AS 'ID', 
         pdt.ProductTypeName AS 'Name'
FROM ProductType AS pdt (NOLOCK)
WHERE (pdt.CompanyID = @CompanyID)
 AND (pdt.IsPublic <> 0)

ORDER BY   pdt.Seq

GO