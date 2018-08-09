EXEC [dbo].pts_CheckProc 'pts_Downline_UpdateTitle'
GO

CREATE PROCEDURE [dbo].pts_Downline_UpdateTitle
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Old int ,
   @Title int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

-- Check that all parameters are set
IF @CompanyID > 0 AND @ParentID > 0 AND @ChildID > 0
BEGIN
--	update the title stats
	EXEC pts_Downline_CalcTitle @CompanyID, @ParentID, @ChildID, @Title, @Old

--	check for possible parent promotion / demotion
	EXEC pts_Downline_Promote @CompanyID, @ParentID

-- ******************************************************************************************************
--	Process Custom Company Downline
-- ******************************************************************************************************

--	Process the Traverus Downlines
	IF @CompanyID = 1 EXEC pts_Downline_UpdateTitle_1 @CompanyID, @ParentID, @ChildID, @Old, @Title

END

GO