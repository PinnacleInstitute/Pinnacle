EXEC [dbo].pts_CheckProc 'pts_Promo_Update'
 GO

CREATE PROCEDURE [dbo].pts_Promo_Update ( 
   @PromoID int,
   @MerchantID int,
   @CountryID int,
   @PromoName nvarchar (60),
   @FromEmail nvarchar (60),
   @Subject nvarchar (80),
   @Message nvarchar (200),
   @Status int,
   @TargetArea int,
   @TargetType int,
   @TargetDays int,
   @Target nvarchar (200),
   @StartDate datetime,
   @EndDate datetime,
   @SendDate datetime,
   @Msgs int,
   @TestEmail nvarchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE prm
SET prm.MerchantID = @MerchantID ,
   prm.CountryID = @CountryID ,
   prm.PromoName = @PromoName ,
   prm.FromEmail = @FromEmail ,
   prm.Subject = @Subject ,
   prm.Message = @Message ,
   prm.Status = @Status ,
   prm.TargetArea = @TargetArea ,
   prm.TargetType = @TargetType ,
   prm.TargetDays = @TargetDays ,
   prm.Target = @Target ,
   prm.StartDate = @StartDate ,
   prm.EndDate = @EndDate ,
   prm.SendDate = @SendDate ,
   prm.Msgs = @Msgs ,
   prm.TestEmail = @TestEmail
FROM Promo AS prm
WHERE prm.PromoID = @PromoID

GO