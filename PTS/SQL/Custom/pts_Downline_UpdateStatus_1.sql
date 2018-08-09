EXEC [dbo].pts_CheckProc 'pts_Downline_UpdateStatus_1'
GO

CREATE PROCEDURE [dbo].pts_Downline_UpdateStatus_1
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Old int ,
   @Status int 
AS

SET NOCOUNT ON

-- Check that parameters are set
IF @ParentID > 0 AND @ChildID > 0
BEGIN
--	If the Status changed to cancelled or terminated
	IF @Old < 6 AND @Status >= 6
	BEGIN
--		Remove the Child from the Executive Downline #1 and rollup his children
--		EXEC pts_Downline_Rollup 1, @ChildID

--		Remove the Child from the 2up Downline #2 and rollup his children
		EXEC pts_Downline_Rollup 2, @ChildID

--		Remove the Child from the 6up Downline #3 and orphan his children
		DELETE Downline WHERE Line = 3 AND ChildID = @ChildID
		UPDATE Downline SET ParentID = 0 Where Line = 3 AND ParentID = @ChildID 

--		Remove the Child from the Matrix Downline #4 and rollup his children
		EXEC pts_Downline_Rollup 4, @ChildID

--		Remove the Child from the Compressed Matrix Downline #5 and rollup his children
		EXEC pts_Downline_Rollup 5, @ChildID

	END
	
--	If the active Status changed to inactive or suspended
	IF @Old <= 3 AND ( @Status = 4 OR @Status = 5 )
	BEGIN
--		Remove the Child from the Matrix #5 and rollup his children
		EXEC pts_Downline_Rollup 5, @ChildID
	END
	
--	If the inactive or suspended Status changed to active
	IF @Status <= 3 AND ( @Old = 4 OR @Old = 5 )
	BEGIN
--		Add the new child in the downline
		INSERT INTO DownLine ( Line, ParentID, ChildID, Position ) VALUES ( 5, @ParentID, @ChildID, 0 )

--		link the parent's children to the new child from the matrix downline
		UPDATE Downline SET ParentID = @ChildID WHERE Line = 5 AND ChildID IN (
			SELECT ChildID FROM Downline WHERE Line = 4 AND ParentID = @ChildID )

--		recalculate the position of all children of the parent
		EXEC pts_Downline_Reposition 5, @ParentID

--		recalculate the position of all children of the child
		EXEC pts_Downline_Reposition 5, @ChildID

	END

END

GO