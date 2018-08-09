EXEC [dbo].pts_CheckProc 'pts_SalesStep_Add'
 GO

CREATE PROCEDURE [dbo].pts_SalesStep_Add ( 
   @SalesStepID int OUTPUT,
   @SalesCampaignID int,
   @EmailID int,
   @SalesStepName nvarchar (40),
   @Description nvarchar (100),
   @Seq int,
   @AutoStep int,
   @NextStep int,
   @Delay int,
   @DateNo int,
   @IsBoard bit,
   @BoardRate money,
   @Length int,
   @Email nvarchar (100),
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
   FROM SalesStep (NOLOCK)
   SET @Seq = @Seq + 10
END

INSERT INTO SalesStep (
            SalesCampaignID , 
            EmailID , 
            SalesStepName , 
            Description , 
            Seq , 
            AutoStep , 
            NextStep , 
            Delay , 
            DateNo , 
            IsBoard , 
            BoardRate , 
            Length , 
            Email
            )
VALUES (
            @SalesCampaignID ,
            @EmailID ,
            @SalesStepName ,
            @Description ,
            @Seq ,
            @AutoStep ,
            @NextStep ,
            @Delay ,
            @DateNo ,
            @IsBoard ,
            @BoardRate ,
            @Length ,
            @Email            )

SET @mNewID = @@IDENTITY

SET @SalesStepID = @mNewID

GO