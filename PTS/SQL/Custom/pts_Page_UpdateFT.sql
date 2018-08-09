EXEC [dbo].pts_CheckProc 'pts_Page_UpdateFT'
GO

CREATE PROCEDURE [dbo].pts_Page_UpdateFT
   @PageID int,
   @PageName nvarchar (60),
   @Fields nvarchar (1000),
   @Result int OUTPUT
AS

DECLARE @ID int

SELECT @ID = @PageID FROM PageFT WHERE PageID = @PageID

IF @ID IS NULL
BEGIN
	INSERT INTO PageFT ( PageID, FT ) VALUES ( @PageID, @PageName + ' ' + @Fields )

	SET @Result = 1
END
IF @ID > 0
BEGIN
	UPDATE PageFT
	SET FT = @PageName + ' ' + @Fields
	WHERE PageID = @PageID

	SET @Result = 2
END

GO