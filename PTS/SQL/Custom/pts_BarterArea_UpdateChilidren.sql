EXEC [dbo].pts_CheckProc 'pts_BarterArea_UpdateChildren'
GO

CREATE PROCEDURE [dbo].pts_BarterArea_UpdateChildren
   @BarterAreaID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 1

DECLARE @cnt int

WHILE @BarterAreaID > 0
BEGIN
	SELECT @cnt = COUNT(*) FROM BarterArea WHERE ParentID = @BarterAreaID
	UPDATE BarterArea SET Children = @cnt WHERE BarterAreaID = @BarterAreaID
	SELECT @BarterAreaID = ParentID FROM BarterArea WHERE BarterAreaID = @BarterAreaID
END

GO