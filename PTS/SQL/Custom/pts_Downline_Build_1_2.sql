EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1_2'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1_2
   @CompanyID int ,
   @ParentID int ,
   @ChildID int , 
   @Title int  
AS

-- Build the Traverus 2up Downline #2
SET NOCOUNT ON

-- Build for all Travel Agents
IF @Title >= 2
BEGIN
	DECLARE @Line Int, @Pos int, @NewParentID int, @NextChildID int

--	Set the Line to the 2up Downline #2
	SET @Line = 2

--	Walk up the Enroller Line to find the next Parent that is in Position 3+ 
	SET @NextChildID = @ChildID
	SET @Pos = 0
	WHILE @Pos <= 2 
	BEGIN
--		Get the Child's Enroller Downline record
--		If we didn't find a record, the new parent is set to 0
--		and the position is set to 10, exiting the while loop 
		SET @Pos = 10
		SET @NewParentID = 0
		SELECT @Pos = Position, @NewParentID = ParentID FROM Downline WHERE Line = 0 AND ChildID = @NextChildID

--		If Position <= 2, set the new parent to be the next child 
		IF @Pos <= 2 SET @NextChildID = @NewParentID
	END

--	If we found an upline parent to use, add the member to the downline 
	IF @NewParentID > 0 EXEC pts_Downline_Add @CompanyID, @Line, @NewParentID, @ChildID
END

GO