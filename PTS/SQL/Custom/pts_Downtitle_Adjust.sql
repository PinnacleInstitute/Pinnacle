EXEC [dbo].pts_CheckProc 'pts_Downtitle_Adjust'
GO

CREATE PROCEDURE [dbo].pts_Downtitle_Adjust
   @Line int ,
   @MemberID int ,
   @Leg int ,
   @Title int ,
   @Cnt int 
AS

SET NOCOUNT ON

DECLARE @ID int
SET @ID = 0

-- Search for a record for this line, parent and title
SELECT @ID = DownTitleID FROM DownTitle 
WHERE Line = @Line AND MemberID = @MemberID AND Leg = @Leg AND Title = @Title

-- if we didn't find it, add a new record if the count is > 0
If @ID = 0
BEGIN
	IF @Cnt > 0 
		INSERT INTO DownTitle ( Line, MemberID, Leg, Title, Cnt ) VALUES ( @Line, @MemberID, @Leg, @Title, @Cnt)
END
-- if we found it, increment or decrement the count
If @ID > 0
BEGIN
	UPDATE DownTitle SET Cnt = Cnt + @Cnt WHERE DowntitleID = @ID
END

GO