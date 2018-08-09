EXEC [dbo].pts_CheckProc 'pts_ProductType_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_ProductType_Fetch ( 
   @ProductTypeID int,
   @CompanyID int OUTPUT,
   @ProductTypeName nvarchar (40) OUTPUT,
   @Seq int OUTPUT,
   @IsPrivate bit OUTPUT,
   @IsPublic bit OUTPUT,
   @Description nvarchar (3000) OUTPUT,
   @Levels varchar (5) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = pdt.CompanyID ,
   @ProductTypeName = pdt.ProductTypeName ,
   @Seq = pdt.Seq ,
   @IsPrivate = pdt.IsPrivate ,
   @IsPublic = pdt.IsPublic ,
   @Description = pdt.Description ,
   @Levels = pdt.Levels
FROM ProductType AS pdt (NOLOCK)
WHERE pdt.ProductTypeID = @ProductTypeID

GO