EXEC [dbo].pts_CheckProc 'pts_Award_Update'
 GO

CREATE PROCEDURE [dbo].pts_Award_Update ( 
   @AwardID int,
   @MerchantID int,
   @AwardType int,
   @Seq int,
   @Amount money,
   @Status int,
   @Description nvarchar (100),
   @Cap money,
   @Award money,
   @StartDate datetime,
   @EndDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE awa
SET awa.MerchantID = @MerchantID ,
   awa.AwardType = @AwardType ,
   awa.Seq = @Seq ,
   awa.Amount = @Amount ,
   awa.Status = @Status ,
   awa.Description = @Description ,
   awa.Cap = @Cap ,
   awa.Award = @Award ,
   awa.StartDate = @StartDate ,
   awa.EndDate = @EndDate
FROM Award AS awa
WHERE awa.AwardID = @AwardID

GO