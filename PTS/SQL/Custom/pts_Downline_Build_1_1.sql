EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1_1'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1_1
   @CompanyID int ,
   @ParentID int ,
   @ChildID int , 
   @Title int  
AS

-- Build the Traverus Executive Enroller Downline #1
SET NOCOUNT ON

-- Build for all Executives
IF @Title >= 4
BEGIN
	DECLARE @Line Int, @Done int, @NewTitle int, @NewParentID int, @NextChildID int

--	Set the Line to the Executive Enroller Downline #1
	SET @Line = 1

--	Walk up the Enroller Line to find the next Parent that is an Executive (Title >= 4)
	SET @NextChildID = @ChildID
	SET @Done = 0
	WHILE @Done <> 0 
	BEGIN
--		Get the Child's Enroller Downline record and their Parent's member title
--		If we didn't find a record, the new parent is set to 0
		SET @NewTitle = 4
		SET @NewParentID = 0
		SELECT @NewTitle = me.Title, @NewParentID = dl.ParentID 
		FROM Downline AS dl
		JOIN Member AS me ON dl.ParentID = me.MemberID
		WHERE Line = 0 AND ChildID = @NextChildID

--		If their title is >= 4, we found the next executive
		If @NewTitle >= 4 SET @Done = 1	

--		If their title < 4, set the new parent to be the next child 
		IF @NewTitle < 4 SET @NextChildID = @NewParentID
	END

--	If we found an upline parent to use, add the member to the downline 
	IF @NewParentID > 0 EXEC pts_Downline_Add @CompanyID, @Line, @NewParentID, @ChildID
END

GO