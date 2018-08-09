EXEC [dbo].pts_CheckProc 'pts_ProductType_Add'
 GO

CREATE PROCEDURE [dbo].pts_ProductType_Add ( 
   @ProductTypeID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()

IF @Seq=0
BEGIN
   SELECT @Seq = ISNULL(MAX(Seq),0)
   FROM ProductType (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO ProductType (
            CompanyID , 
            ProductTypeName , 
            Seq , 
            IsPrivate , 
            IsPublic , 
            Description , 
            Levels
            )
VALUES (
            @CompanyID ,
            @ProductTypeName ,
            @Seq ,
            @IsPrivate ,
            @IsPublic ,
            @Description ,
            @Levels            )

SET @mNewID = @@IDENTITY

SET @ProductTypeID = @mNewID

GO