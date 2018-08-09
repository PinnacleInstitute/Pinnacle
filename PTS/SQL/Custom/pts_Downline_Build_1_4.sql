EXEC [dbo].pts_CheckProc 'pts_Downline_Build_1_4'
GO

CREATE PROCEDURE [dbo].pts_Downline_Build_1_4
   @CompanyID int ,
   @ParentID int ,
   @ChildID int , 
   @Title int  
AS

-- Build the Traverus Matrix Downline #4
SET NOCOUNT ON

-- Build for all Travel Agents
IF @Title >= 2
BEGIN
	DECLARE @Line Int, @ID int
--	Set the Line to the Matrix Downline #4
	SET @Line = 4

--	If the member already exists in the Matrix, don't rebuild them
	SELECT @ID = DownlineID FROM Downline WHERE Line = @Line AND ChildID = @ChildID
	IF @ID IS NULL
	BEGIN
--		Walk down the Matrix Line to find the next Parent that does not have 3 children
		DECLARE  @NewParentID int, @Level int, @Position int, @Children int, @Levels int
		SELECT @NewParentID = @ParentID, @Level = 1, @Levels = 100
		EXEC pts_Downline_Build_1_4a @NewParentID OUTPUT, @Level OUTPUT, @Children OUTPUT, @Position OUTPUT, @Levels OUTPUT

--		If we found an upline parent to use, add the member to the downline 
		IF @NewParentID > 0 
		BEGIN
			EXEC pts_Downline_Add @CompanyID, @Line, @NewParentID, @ChildID
--			If we added the member, Build Compressed Matrix Downline
			IF @Result = 1 EXEC pts_Downline_Build_1_5 @CompanyID, @NewParentID, @ChildID, @Title  
		END
	END
END

GO