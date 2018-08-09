EXEC [dbo].pts_CheckProc 'pts_MemberTax_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberTax_Fetch ( 
   @MemberTaxID int,
   @MemberID int OUTPUT,
   @Year int OUTPUT,
   @VehicleMethod int OUTPUT,
   @MilesStart int OUTPUT,
   @MilesEnd int OUTPUT,
   @TotalMiles int OUTPUT,
   @BusMiles int OUTPUT,
   @VehicleRate int OUTPUT,
   @TotalSpace int OUTPUT,
   @BusSpace int OUTPUT,
   @SpaceRate int OUTPUT,
   @Notes nvarchar (2000) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = mtx.MemberID ,
   @Year = mtx.Year ,
   @VehicleMethod = mtx.VehicleMethod ,
   @MilesStart = mtx.MilesStart ,
   @MilesEnd = mtx.MilesEnd ,
   @TotalMiles = mtx.TotalMiles ,
   @BusMiles = mtx.BusMiles ,
   @VehicleRate = mtx.VehicleRate ,
   @TotalSpace = mtx.TotalSpace ,
   @BusSpace = mtx.BusSpace ,
   @SpaceRate = mtx.SpaceRate ,
   @Notes = mtx.Notes
FROM MemberTax AS mtx (NOLOCK)
WHERE mtx.MemberTaxID = @MemberTaxID

GO