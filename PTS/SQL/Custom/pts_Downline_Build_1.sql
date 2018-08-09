EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1
   @CompanyID int ,
   @ParentID int ,
   @ChildID int 
AS

-- Build the Traverus Downlines
SET NOCOUNT ON

DECLARE @Title int

-- Get member Title
SELECT @Title = Title FROM Member WHERE MemberID = @ChildID
--TEST
--SET @Title = 2

-- Build for all Travel Agents
IF @Title >= 2
BEGIN
--	Build Executive Enroller Downline #1
--	IF @Title >= 4 EXEC pts_Downline_Build_1_1 @CompanyID, @ParentID, @ChildID, @Title

--	Build 2up Downline #2
	EXEC pts_Downline_Build_1_2 @CompanyID, @ParentID, @ChildID, @Title

--	Build 6up Downline #3
	EXEC pts_Downline_Build_1_3 @CompanyID, @ParentID, @ChildID, @Title

--	Build Matrix Downline #4
	EXEC pts_Downline_Build_1_4 @CompanyID, @ParentID, @ChildID, @Title
END

GO
