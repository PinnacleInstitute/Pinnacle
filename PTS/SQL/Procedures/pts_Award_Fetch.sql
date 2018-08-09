EXEC [dbo].pts_CheckProc 'pts_Award_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Award_Fetch ( 
   @AwardID int,
   @MerchantID int OUTPUT,
   @AwardType int OUTPUT,
   @Seq int OUTPUT,
   @Amount money OUTPUT,
   @Status int OUTPUT,
   @Description nvarchar (100) OUTPUT,
   @Cap money OUTPUT,
   @Award money OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = awa.MerchantID ,
   @AwardType = awa.AwardType ,
   @Seq = awa.Seq ,
   @Amount = awa.Amount ,
   @Status = awa.Status ,
   @Description = awa.Description ,
   @Cap = awa.Cap ,
   @Award = awa.Award ,
   @StartDate = awa.StartDate ,
   @EndDate = awa.EndDate
FROM Award AS awa (NOLOCK)
WHERE awa.AwardID = @AwardID

GO