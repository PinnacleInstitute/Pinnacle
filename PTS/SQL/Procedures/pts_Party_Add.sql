EXEC [dbo].pts_CheckProc 'pts_Party_Add'
 GO

CREATE PROCEDURE [dbo].pts_Party_Add ( 
   @PartyID int OUTPUT,
   @ApptID int,
   @NameLast nvarchar (15),
   @NameFirst nvarchar (15),
   @Email nvarchar (80),
   @IsTrained bit,
   @Phone nvarchar (30),
   @Location nvarchar (60),
   @Street nvarchar (60),
   @Unit nvarchar (40),
   @City nvarchar (30),
   @State nvarchar (30),
   @Zip nvarchar (20),
   @Country nvarchar (30),
   @IsMap bit,
   @Message nvarchar (2000),
   @Theme int,
   @CustomTheme int,
   @Sales money,
   @IsShop bit,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Party (
            ApptID , 
            NameLast , 
            NameFirst , 
            Email , 
            IsTrained , 
            Phone , 
            Location , 
            Street , 
            Unit , 
            City , 
            State , 
            Zip , 
            Country , 
            IsMap , 
            Message , 
            Theme , 
            CustomTheme , 
            Sales , 
            IsShop
            )
VALUES (
            @ApptID ,
            @NameLast ,
            @NameFirst ,
            @Email ,
            @IsTrained ,
            @Phone ,
            @Location ,
            @Street ,
            @Unit ,
            @City ,
            @State ,
            @Zip ,
            @Country ,
            @IsMap ,
            @Message ,
            @Theme ,
            @CustomTheme ,
            @Sales ,
            @IsShop            )

SET @mNewID = @@IDENTITY

SET @PartyID = @mNewID

GO