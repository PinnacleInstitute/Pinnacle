EXEC [dbo].pts_CheckProc 'pts_Downline_CalcTitle'
GO

CREATE PROCEDURE [dbo].pts_Downline_CalcTitle
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Title int ,
   @Dec int
AS

SET NOCOUNT ON

-- Check that parameters are set
IF @CompanyID > 0 AND @ParentID > 0 AND @ChildID > 0 
BEGIN
	DECLARE @Line int, @ID int
	SET @Line = 0
	
	WHILE @ParentID > 0 
	BEGIN
--		Increment the title count for the member		
		IF @Title > 0 EXEC pts_Downtitle_Adjust @Line, @ParentID, @ChildID, @Title, 1
		
--		Decrement the title count for the member		
		IF @Dec > 0 EXEC pts_Downtitle_Adjust @Line, @ParentID, @ChildID, @Dec, -1

--		Save the current parent as the next upline leg
		SET @ChildID = @ParentID

--		Get the next upline parent 
		SET @ID = 0
		SELECT @ID = ParentID FROM Downline WHERE Line = @Line AND ChildID = @ParentID
		SET @ParentID = @ID
	END
END

GO