EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1_5'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1_5
   @CompanyID int ,
   @ParentID int ,
   @ChildID int , 
   @Title int  
AS

-- Build the Traverus Compressed Matrix Downline #5
SET NOCOUNT ON

-- Build for all Travel Agents
IF @Title >= 2
BEGIN
	DECLARE @Line Int
--	Set the Line to the Compressed Matrix Downline #5
	SET @Line = 5

--	add the member to the downline 
	EXEC pts_Downline_Add @CompanyID, @Line, @ParentID, @ChildID
END

GO