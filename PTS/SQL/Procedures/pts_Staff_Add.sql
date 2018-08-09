EXEC [dbo].pts_CheckProc 'pts_Staff_Add'
 GO

CREATE PROCEDURE [dbo].pts_Staff_Add ( 
   @StaffID int OUTPUT,
   @MerchantID int,
   @ConsumerID int,
   @StaffName nvarchar (40),
   @Code int,
   @Status int,
   @StaffDate datetime,
   @Access varchar (80),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Staff (
            MerchantID , 
            ConsumerID , 
            StaffName , 
            Code , 
            Status , 
            StaffDate , 
            Access
            )
VALUES (
            @MerchantID ,
            @ConsumerID ,
            @StaffName ,
            @Code ,
            @Status ,
            @StaffDate ,
            @Access            )

SET @mNewID = @@IDENTITY

SET @StaffID = @mNewID

GO