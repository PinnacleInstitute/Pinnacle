EXEC [dbo].pts_CheckProc 'pts_Promotion_Add'
 GO

CREATE PROCEDURE [dbo].pts_Promotion_Add ( 
   @PromotionID int OUTPUT,
   @CompanyID int,
   @ProductID int,
   @PromotionName nvarchar (60),
   @Description nvarchar (500),
   @Code nvarchar (6),
   @Amount money,
   @Rate money,
   @StartDate datetime,
   @EndDate datetime,
   @Qty int,
   @Used int,
   @Products nvarchar (50),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Promotion (
            CompanyID , 
            ProductID , 
            PromotionName , 
            Description , 
            Code , 
            Amount , 
            Rate , 
            StartDate , 
            EndDate , 
            Qty , 
            Used , 
            Products
            )
VALUES (
            @CompanyID ,
            @ProductID ,
            @PromotionName ,
            @Description ,
            @Code ,
            @Amount ,
            @Rate ,
            @StartDate ,
            @EndDate ,
            @Qty ,
            @Used ,
            @Products            )

SET @mNewID = @@IDENTITY

SET @PromotionID = @mNewID

GO