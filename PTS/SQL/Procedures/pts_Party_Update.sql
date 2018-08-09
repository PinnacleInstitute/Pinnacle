EXEC [dbo].pts_CheckProc 'pts_Party_Update'
 GO

CREATE PROCEDURE [dbo].pts_Party_Update ( 
   @PartyID int,
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

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE py
SET py.ApptID = @ApptID ,
   py.NameLast = @NameLast ,
   py.NameFirst = @NameFirst ,
   py.Email = @Email ,
   py.IsTrained = @IsTrained ,
   py.Phone = @Phone ,
   py.Location = @Location ,
   py.Street = @Street ,
   py.Unit = @Unit ,
   py.City = @City ,
   py.State = @State ,
   py.Zip = @Zip ,
   py.Country = @Country ,
   py.IsMap = @IsMap ,
   py.Message = @Message ,
   py.Theme = @Theme ,
   py.CustomTheme = @CustomTheme ,
   py.Sales = @Sales ,
   py.IsShop = @IsShop
FROM Party AS py
WHERE py.PartyID = @PartyID

GO