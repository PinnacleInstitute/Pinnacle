EXEC [dbo].pts_CheckProc 'pts_Downline_UpdateStatus'
GO

CREATE PROCEDURE [dbo].pts_Downline_UpdateStatus
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Old int ,
   @Status int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

-- Check that all parameters are set
IF @CompanyID > 0 AND @ParentID > 0 AND @ChildID > 0
BEGIN
	SET @Result = 1

--	If Status changed to cancelled or terminated, Remove the Child from the Enroller Downline #0 and rollup his children
	IF @Status >= 6
	BEGIN
		EXEC pts_Downline_Rollup 0, @ParentID, @ChildID

--		update the title stats with deleted member title
		DECLARE @Title int
		SELECT @Title = Title FROM Member WHERE MemberID = @ChildID
		EXEC pts_Downline_CalcTitle @CompanyID, @ParentID, @ChildID, 0, @Title

--		check for possible parent demotion
		EXEC pts_Downline_Promote @CompanyID, @ParentID
	END

-- ******************************************************************************************************
--	Process Custom Company Downline
-- ******************************************************************************************************
--	Process the Traverus Downlines
	IF @CompanyID = 1 EXEC pts_Downline_UpdateStatus_1 @CompanyID, @ParentID, @ChildID, @Old, @Status

END

GO