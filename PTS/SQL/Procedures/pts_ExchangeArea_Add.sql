EXEC [dbo].pts_CheckProc 'pts_ExchangeArea_Add'
 GO

CREATE PROCEDURE [dbo].pts_ExchangeArea_Add ( 
   @ExchangeAreaID int OUTPUT,
   @ExchangeID int,
   @CountryID int,
   @State nvarchar (20),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO ExchangeArea (
            ExchangeID , 
            CountryID , 
            State
            )
VALUES (
            @ExchangeID ,
            @CountryID ,
            @State            )

SET @mNewID = @@IDENTITY

SET @ExchangeAreaID = @mNewID

GO