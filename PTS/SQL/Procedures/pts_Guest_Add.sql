EXEC [dbo].pts_CheckProc 'pts_Guest_Add'
 GO

CREATE PROCEDURE [dbo].pts_Guest_Add ( 
   @GuestID int OUTPUT,
   @PartyID int,
   @NameLast nvarchar (15),
   @NameFirst nvarchar (15),
   @Email nvarchar (80),
   @Status int,
   @Attend bit,
   @Sale money,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Guest (
            PartyID , 
            NameLast , 
            NameFirst , 
            Email , 
            Status , 
            Attend , 
            Sale
            )
VALUES (
            @PartyID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @Status ,
            @Attend ,
            @Sale            )

SET @mNewID = @@IDENTITY

SET @GuestID = @mNewID

GO