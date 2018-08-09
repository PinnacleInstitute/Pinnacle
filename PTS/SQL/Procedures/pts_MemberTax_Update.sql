EXEC [dbo].pts_CheckProc 'pts_MemberTax_Update'
 GO

CREATE PROCEDURE [dbo].pts_MemberTax_Update ( 
   @MemberTaxID int,
   @MemberID int,
   @Year int,
   @VehicleMethod int,
   @MilesStart int,
   @MilesEnd int,
   @TotalMiles int,
   @BusMiles int,
   @VehicleRate int,
   @TotalSpace int,
   @BusSpace int,
   @SpaceRate int,
   @Notes nvarchar (2000),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE mtx
SET mtx.MemberID = @MemberID ,
   mtx.Year = @Year ,
   mtx.VehicleMethod = @VehicleMethod ,
   mtx.MilesStart = @MilesStart ,
   mtx.MilesEnd = @MilesEnd ,
   mtx.TotalMiles = @TotalMiles ,
   mtx.BusMiles = @BusMiles ,
   mtx.VehicleRate = @VehicleRate ,
   mtx.TotalSpace = @TotalSpace ,
   mtx.BusSpace = @BusSpace ,
   mtx.SpaceRate = @SpaceRate ,
   mtx.Notes = @Notes
FROM MemberTax AS mtx
WHERE mtx.MemberTaxID = @MemberTaxID

GO