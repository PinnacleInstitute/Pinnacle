EXEC [dbo].pts_CheckProc 'pts_MemberTax_Add'
 GO

CREATE PROCEDURE [dbo].pts_MemberTax_Add ( 
   @MemberTaxID int OUTPUT,
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
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO MemberTax (
            MemberID , 
            Year , 
            VehicleMethod , 
            MilesStart , 
            MilesEnd , 
            TotalMiles , 
            BusMiles , 
            VehicleRate , 
            TotalSpace , 
            BusSpace , 
            SpaceRate , 
            Notes
            )
VALUES (
            @MemberID ,
            @Year ,
            @VehicleMethod ,
            @MilesStart ,
            @MilesEnd ,
            @TotalMiles ,
            @BusMiles ,
            @VehicleRate ,
            @TotalSpace ,
            @BusSpace ,
            @SpaceRate ,
            @Notes            )

SET @mNewID = @@IDENTITY

SET @MemberTaxID = @mNewID

GO