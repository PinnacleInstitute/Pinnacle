EXEC [dbo].pts_CheckProc 'pts_Award_Add'
 GO

CREATE PROCEDURE [dbo].pts_Award_Add ( 
   @AwardID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Award (
            MerchantID , 
            AwardType , 
            Seq , 
            Amount , 
            Status , 
            Description , 
            Cap , 
            Award , 
            StartDate , 
            EndDate
            )
VALUES (
            @MerchantID ,
            @AwardType ,
            @Seq ,
            @Amount ,
            @Status ,
            @Description ,
            @Cap ,
            @Award ,
            @StartDate ,
            @EndDate            )

SET @mNewID = @@IDENTITY

SET @AwardID = @mNewID

GO