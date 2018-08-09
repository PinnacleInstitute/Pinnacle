EXEC [dbo].pts_CheckProc 'pts_ProductType_EnumUserCompany'
GO

CREATE PROCEDURE [dbo].pts_ProductType_EnumUserCompany
   @CompanyID int ,
   @Levels nvarchar (5) ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      pdt.ProductTypeID AS 'ID', 
         pdt.ProductTypeName AS 'Name'
FROM ProductType AS pdt (NOLOCK)
WHERE (pdt.CompanyID = @CompanyID)
 AND (pdt.IsPrivate = 0)
 AND ((pdt.Levels = '')
 OR (pdt.Levels LIKE '%'  + @Levels + '%'))

ORDER BY   pdt.Seq

GO