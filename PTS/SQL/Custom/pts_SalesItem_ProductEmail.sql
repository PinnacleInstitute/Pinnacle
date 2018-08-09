EXEC [dbo].pts_CheckProc 'pts_SalesItem_ProductEmail'
GO

CREATE PROCEDURE [dbo].pts_SalesItem_ProductEmail
   @SalesItemID int ,
   @Email nvarchar(80) OUTPUT
AS

SELECT @Email = pd.Email
FROM   Product AS pd (NOLOCK)
       LEFT OUTER JOIN SalesItem AS si (NOLOCK) ON (pd.ProductID = si.ProductID)
WHERE  si.SalesItemID = @SalesItemID

GO
