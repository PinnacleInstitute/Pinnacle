EXEC [dbo].pts_CheckProc 'pts_Downline_Build'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

-- Check that all parameters are set
IF @CompanyID > 0 AND @ParentID > 0 AND @ChildID > 0
BEGIN
--	Return result that we processed the build
	SET @Result = 1

-- ******************************************************************************************************
--	Process Custom Company Downline
-- ******************************************************************************************************
--	Build the WRN Downlines
	IF @CompanyID = 5 EXEC pts_Downline_Build_5 @CompanyID, @ParentID, @ChildID

--	Build the WRN Downlines
	IF @CompanyID = 7 EXEC pts_Downline_Build_7 @CompanyID, @ParentID, @ChildID

--	Build the ZaZZed Downlines
	IF @CompanyID = 9 EXEC pts_Downline_Build_9 @CompanyID, @ParentID, @ChildID

--	Build the GFT Global Downlines
	IF @CompanyID = 13 EXEC pts_Downline_Build_13 @CompanyID, @ParentID, @ChildID

--	Build the Legacy Max Downlines
	IF @CompanyID = 14 EXEC pts_Downline_Build_14 @CompanyID, @ParentID, @ChildID
END

GO