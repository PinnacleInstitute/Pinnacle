EXEC [dbo].pts_CheckProc 'pts_Downline_Promote'
GO

CREATE PROCEDURE [dbo].pts_Downline_Promote
   @CompanyID int ,
   @ParentID int
AS

SET NOCOUNT ON
DECLARE @Title int, @TitleDate datetime, @StartTitle int, @UpdateTitle int, @Qualified int, @ChildID int, @ID int
DECLARE @Now datetime
SET @Now = GETDATE()

WHILE @ParentID > 0 
BEGIN
--	get the member's title
	SELECT @Title = Title, @TitleDate = TitleDate FROM Member WHERE MemberID = @ParentID
	SELECT @StartTitle = @Title, @UpdateTitle = 0, @Qualified = -1

--	Check if the current title is qualified
	IF @CompanyID = 1 EXEC pts_Downline_Qualify_1 @CompanyID, @ParentID, @Title, @Qualified OUTPUT

-- 	If the qualification test was performed
	IF @Qualified >= 0
	BEGIN
--		If the current title is qualified, look at the next statuses until not qualified
		IF @Qualified = 1
		BEGIN
			WHILE @Qualified = 1
			BEGIN
				SELECT @Title = @Title + 1, @Qualified = 0
				IF @CompanyID = 1 EXEC pts_Downline_Qualify_1 @CompanyID, @ParentID, @Title, @Qualified OUTPUT
			END
			SET @Title = @Title - 1
		END
--		Else If the current title is not qualified, look at the previous statuses until qualified
		ELSE
		BEGIN
			WHILE @Qualified = 0
			BEGIN
				SELECT @Title = @Title - 1, @Qualified = 1
				IF @CompanyID = 1 EXEC pts_Downline_Qualify_1 @CompanyID, @ParentID, @Title, @Qualified OUTPUT
			END
		END
	END

	SET @UpdateTitle = 0
--	If there is a title change, update the title if allowed
	IF @StartTitle <> @Title 
	BEGIN
--		check if we can change the status
		IF @TitleDate = 0 OR @TitleDate < @Now OR @Title > @StartTitle SET @UpdateTitle = 1

--		Update the Member's title, if allowed
		IF @UpdateTitle = 1 
		BEGIN
			UPDATE Member SET Title = @Title WHERE MemberID = @ParentID
--			Add member title change
			EXEC pts_MemberTitle_Add  @ID, @ParentID, @Now, @Title, 1
		END
	END

--	Get the next upline parent to calculate their possible promotion
--	Save the current member as the child leg for the next parent
	SET @ChildID = @ParentID
	SET @ID = 0
	SELECT @ID = ParentID FROM Downline WHERE Line = 0 AND ChildID = @ParentID
	SET @ParentID = @ID

--	If we updated the title and we have a new parent, update its title stats
	IF @UpdateTitle = 1 AND @ParentID > 0
		EXEC pts_Downline_CalcTitle @CompanyID, @ParentID, @ChildID, @Title, @StartTitle
END

GO
