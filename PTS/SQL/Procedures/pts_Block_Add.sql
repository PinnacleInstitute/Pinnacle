EXEC [dbo].pts_CheckProc 'pts_Block_Add'
 GO

CREATE PROCEDURE [dbo].pts_Block_Add ( 
   @BlockID int OUTPUT,
   @ConsumerID int,
   @MerchantID int,
   @BlockDate datetime,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Block (
            ConsumerID , 
            MerchantID , 
            BlockDate
            )
VALUES (
            @ConsumerID ,
            @MerchantID ,
            @BlockDate            )

SET @mNewID = @@IDENTITY

SET @BlockID = @mNewID

GO