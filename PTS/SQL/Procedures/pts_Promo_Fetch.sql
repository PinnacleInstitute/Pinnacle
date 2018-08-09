EXEC [dbo].pts_CheckProc 'pts_Promo_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Promo_Fetch ( 
   @PromoID int,
   @MerchantID int OUTPUT,
   @CountryID int OUTPUT,
   @PromoName nvarchar (60) OUTPUT,
   @FromEmail nvarchar (60) OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @Message nvarchar (200) OUTPUT,
   @Status int OUTPUT,
   @TargetArea int OUTPUT,
   @TargetType int OUTPUT,
   @TargetDays int OUTPUT,
   @Target nvarchar (200) OUTPUT,
   @StartDate datetime OUTPUT,
   @EndDate datetime OUTPUT,
   @SendDate datetime OUTPUT,
   @Msgs int OUTPUT,
   @TestEmail nvarchar (80) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MerchantID = prm.MerchantID ,
   @CountryID = prm.CountryID ,
   @PromoName = prm.PromoName ,
   @FromEmail = prm.FromEmail ,
   @Subject = prm.Subject ,
   @Message = prm.Message ,
   @Status = prm.Status ,
   @TargetArea = prm.TargetArea ,
   @TargetType = prm.TargetType ,
   @TargetDays = prm.TargetDays ,
   @Target = prm.Target ,
   @StartDate = prm.StartDate ,
   @EndDate = prm.EndDate ,
   @SendDate = prm.SendDate ,
   @Msgs = prm.Msgs ,
   @TestEmail = prm.TestEmail
FROM Promo AS prm (NOLOCK)
WHERE prm.PromoID = @PromoID

GO