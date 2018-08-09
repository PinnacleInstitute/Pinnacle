EXEC [dbo].pts_CheckProc 'pts_ProductType_EnumUserCompanyAll'
GO

CREATE PROCEDURE [dbo].pts_ProductType_EnumUserCompanyAll
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pdt.ProductTypeID AS 'ID', 
         pdt.ProductTypeName AS 'Name'
FROM ProductType AS pdt (NOLOCK)
WHERE (pdt.CompanyID = @CompanyID)

ORDER BY   pdt.Seq

GO