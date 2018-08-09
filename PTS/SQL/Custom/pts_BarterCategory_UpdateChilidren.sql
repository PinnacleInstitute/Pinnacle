EXEC [dbo].pts_CheckProc 'pts_BarterCategory_UpdateChildren'
GO

CREATE PROCEDURE [dbo].pts_BarterCategory_UpdateChildren
   @BarterCategoryID int ,
   @Status int OUTPUT
AS

SET NOCOUNT ON
SET @Status = 1

DECLARE @cnt int

WHILE @BarterCategoryID > 0
BEGIN
	SELECT @cnt = COUNT(*) FROM BarterCategory WHERE ParentID = @BarterCategoryID
	UPDATE BarterCategory SET Children = @cnt WHERE BarterCategoryID = @BarterCategoryID
	SELECT @BarterCategoryID = ParentID FROM BarterCategory WHERE BarterCategoryID = @BarterCategoryID
END

GO