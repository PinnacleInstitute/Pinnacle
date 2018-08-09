EXEC [dbo].pts_CheckProc 'pts_BroadcastNews_Add'
GO
--DECLARE @ID int EXEC pts_BroadcastNews_Add 1, 1, @ID output print @ID

CREATE PROCEDURE [dbo].pts_BroadcastNews_Add
   @BroadcastID int ,
   @NewsID int ,
   @Result int OUTPUT
AS
SET NOCOUNT ON
DECLARE @ID int

SET @Result = 0
--Check if the News has already beed added to this Broadcast
SELECT @Result = BroadcastNewsID FROM BroadcastNews WHERE BroadcastID = @BroadcastID AND NewsID = @NewsID
IF @Result = 0 
BEGIN
	INSERT INTO BroadcastNews ( BroadcastID, NewsID ) VALUES ( @BroadcastID, @NewsID )
	SET @Result = @@IDENTITY

	UPDATE Broadcast SET Stories = Stories + 1 WHERE BroadcastID = @BroadcastID
END
ELSE
	SET @Result = 0


GO