EXEC [dbo].pts_CheckProc 'pts_BarterAd_UpdateFT'
GO

CREATE PROCEDURE [dbo].pts_BarterAd_UpdateFT
   @BarterAdID int,
   @Title nvarchar (100),
   @Location nvarchar (40),
   @Zip nvarchar (10),
   @Description nvarchar (4000),
   @Result int OUTPUT
AS

DECLARE @ID int, @FT nvarchar(4000)
SET @FT = LEFT( @Title + ' ' + @Location + ' ' + @Zip + ' ' + @Description, 4000)

SELECT @ID = @BarterAdID FROM BarterAdFT WHERE BarterAdID = @BarterAdID

IF @ID IS NULL
BEGIN
	INSERT INTO BarterAdFT ( BarterAdID, FT ) VALUES ( @BarterAdID, @FT )
	SET @Result = 1
END
IF @ID > 0
BEGIN
	UPDATE BarterAdFT SET FT = @FT WHERE BarterAdID = @BarterAdID
	SET @Result = 2
END

GO

