EXEC [dbo].pts_CheckProc 'pts_SalesStep_Update'
 GO

CREATE PROCEDURE [dbo].pts_SalesStep_Update ( 
   @SalesStepID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE sls
SET sls.SalesCampaignID = @SalesCampaignID ,
   sls.EmailID = @EmailID ,
   sls.SalesStepName = @SalesStepName ,
   sls.Description = @Description ,
   sls.Seq = @Seq ,
   sls.AutoStep = @AutoStep ,
   sls.NextStep = @NextStep ,
   sls.Delay = @Delay ,
   sls.DateNo = @DateNo ,
   sls.IsBoard = @IsBoard ,
   sls.BoardRate = @BoardRate ,
   sls.Length = @Length ,
   sls.Email = @Email
FROM SalesStep AS sls
WHERE sls.SalesStepID = @SalesStepID

GO