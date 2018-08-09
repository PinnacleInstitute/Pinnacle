EXEC [dbo].pts_CheckProc 'pts_SalesStep_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_SalesStep_Fetch ( 
   @SalesStepID int,
   @SalesCampaignID int OUTPUT,
   @EmailID int OUTPUT,
   @SalesStepName nvarchar (40) OUTPUT,
   @Description nvarchar (100) OUTPUT,
   @Seq int OUTPUT,
   @AutoStep int OUTPUT,
   @NextStep int OUTPUT,
   @Delay int OUTPUT,
   @DateNo int OUTPUT,
   @IsBoard bit OUTPUT,
   @BoardRate money OUTPUT,
   @Length int OUTPUT,
   @Email nvarchar (100) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @SalesCampaignID = sls.SalesCampaignID ,
   @EmailID = sls.EmailID ,
   @SalesStepName = sls.SalesStepName ,
   @Description = sls.Description ,
   @Seq = sls.Seq ,
   @AutoStep = sls.AutoStep ,
   @NextStep = sls.NextStep ,
   @Delay = sls.Delay ,
   @DateNo = sls.DateNo ,
   @IsBoard = sls.IsBoard ,
   @BoardRate = sls.BoardRate ,
   @Length = sls.Length ,
   @Email = sls.Email
FROM SalesStep AS sls (NOLOCK)
WHERE sls.SalesStepID = @SalesStepID

GO