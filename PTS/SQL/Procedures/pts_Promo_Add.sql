EXEC [dbo].pts_CheckProc 'pts_Promo_Add'
 GO

CREATE PROCEDURE [dbo].pts_Promo_Add ( 
   @PromoID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Promo (
            MerchantID , 
            CountryID , 
            PromoName , 
            FromEmail , 
            Subject , 
            Message , 
            Status , 
            TargetArea , 
            TargetType , 
            TargetDays , 
            Target , 
            StartDate , 
            EndDate , 
            SendDate , 
            Msgs , 
            TestEmail
            )
VALUES (
            @MerchantID ,
            @CountryID ,
            @PromoName ,
            @FromEmail ,
            @Subject ,
            @Message ,
            @Status ,
            @TargetArea ,
            @TargetType ,
            @TargetDays ,
            @Target ,
            @StartDate ,
            @EndDate ,
            @SendDate ,
            @Msgs ,
            @TestEmail            )

SET @mNewID = @@IDENTITY

SET @PromoID = @mNewID

GO