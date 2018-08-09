EXEC [dbo].pts_CheckProc 'pts_MemberTax_List'
GO

CREATE PROCEDURE [dbo].pts_MemberTax_List
   @MemberID int
AS

SET NOCOUNT ON

SELECT      mtx.MemberTaxID, 
         mtx.Year, 
         mtx.VehicleMethod, 
         mtx.MilesStart, 
         mtx.MilesEnd, 
         mtx.TotalMiles, 
         mtx.BusMiles, 
         mtx.VehicleRate, 
         mtx.TotalSpace, 
         mtx.BusSpace, 
         mtx.SpaceRate
FROM MemberTax AS mtx (NOLOCK)
WHERE (mtx.MemberID = @MemberID)

ORDER BY   mtx.Year DESC

GO