EXEC [dbo].pts_CheckProc 'pts_ProductType_Update'
 GO

CREATE PROCEDURE [dbo].pts_ProductType_Update ( 
   @ProductTypeID int,
   @CompanyID int,
   @ProductTypeName nvarchar (40),
   @Seq int,
   @IsPrivate bit,
   @IsPublic bit,
   @Description nvarchar (3000),
   @Levels varchar (5),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE pdt
SET pdt.CompanyID = @CompanyID ,
   pdt.ProductTypeName = @ProductTypeName ,
   pdt.Seq = @Seq ,
   pdt.IsPrivate = @IsPrivate ,
   pdt.IsPublic = @IsPublic ,
   pdt.Description = @Description ,
   pdt.Levels = @Levels
FROM ProductType AS pdt
WHERE pdt.ProductTypeID = @ProductTypeID

GO