EXEC [dbo].pts_CheckProc 'pts_Party_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Party_Fetch ( 
   @PartyID int,
   @ApptID int OUTPUT,
   @PartyName nvarchar (60) OUTPUT,
   @StartDate datetime OUTPUT,
   @StartTime nvarchar (8) OUTPUT,
   @EndDate datetime OUTPUT,
   @EndTime nvarchar (8) OUTPUT,
   @NameLast nvarchar (15) OUTPUT,
   @NameFirst nvarchar (15) OUTPUT,
   @HostName nvarchar (32) OUTPUT,
   @Email nvarchar (80) OUTPUT,
   @IsTrained bit OUTPUT,
   @Phone nvarchar (30) OUTPUT,
   @Location nvarchar (60) OUTPUT,
   @Street nvarchar (60) OUTPUT,
   @Unit nvarchar (40) OUTPUT,
   @City nvarchar (30) OUTPUT,
   @State nvarchar (30) OUTPUT,
   @Zip nvarchar (20) OUTPUT,
   @Country nvarchar (30) OUTPUT,
   @IsMap bit OUTPUT,
   @Message nvarchar (2000) OUTPUT,
   @Theme int OUTPUT,
   @CustomTheme int OUTPUT,
   @Sales money OUTPUT,
   @IsShop bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @ApptID = py.ApptID ,
   @PartyName = ap.ApptName ,
   @StartDate = ap.StartDate ,
   @StartTime = ap.StartTime ,
   @EndDate = ap.EndDate ,
   @EndTime = ap.EndTime ,
   @NameLast = py.NameLast ,
   @NameFirst = py.NameFirst ,
   @HostName = LTRIM(RTRIM(py.NameFirst)) +  ' '  + LTRIM(RTRIM(py.NameLast)) ,
   @Email = py.Email ,
   @IsTrained = py.IsTrained ,
   @Phone = py.Phone ,
   @Location = py.Location ,
   @Street = py.Street ,
   @Unit = py.Unit ,
   @City = py.City ,
   @State = py.State ,
   @Zip = py.Zip ,
   @Country = py.Country ,
   @IsMap = py.IsMap ,
   @Message = py.Message ,
   @Theme = py.Theme ,
   @CustomTheme = py.CustomTheme ,
   @Sales = py.Sales ,
   @IsShop = py.IsShop
FROM Party AS py (NOLOCK)
LEFT OUTER JOIN Appt AS ap (NOLOCK) ON (py.ApptID = ap.ApptID)
WHERE py.PartyID = @PartyID

GO