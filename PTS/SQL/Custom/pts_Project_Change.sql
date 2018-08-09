EXEC [dbo].pts_CheckProc 'pts_Project_Change'
GO

CREATE PROCEDURE [dbo].pts_Project_Change
   @ProjectID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
DECLARE @Now datetime, @ParentID int
SET @Now = GETDATE()

WHILE @ProjectID > 0
BEGIN
	UPDATE Project SET ChangeDate = @Now WHERE ProjectID = @ProjectID
	SELECT @ParentID = ParentID FROM Project WHERE ProjectID = @ProjectID
	SET @ProjectID = @ParentID
END

GO