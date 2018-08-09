EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_5_Title'
GO


--EXEC pts_Commission_CalcAdvancement_5_Title 521, 1


CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_5_Title
	@MemberID int, 
	@NewTitle int 
AS

SET NOCOUNT ON

DECLARE @SponsorID int, @PayTitle int, @HighTitle int, @ChildHighTitle int, @Done int 

SELECT @SponsorID = SponsorID, @PayTitle = Title, @HighTitle = MaxMembers FROM Member WHERE MemberID = @MemberID

-- *************************************************************
-- Walk Upline - test for change to highest title 
-- *************************************************************
SET @MemberID = @SponsorID
SET @Done = 0
WHILE @MemberID > 0
BEGIN
	SET @SponsorID = -1
	SELECT @SponsorID = SponsorID FROM Member WHERE MemberID = @MemberID
--	-- TEST if we found the affiliate
	IF @SponsorID >= 0
	BEGIN
--		-- if the new title < the current paytitle, were done
		IF @NewTitle < @PayTitle
			SET @Done = 1
		ELSE
		BEGIN
--			-- if the new title = the current highest title, were done
			IF @NewTitle = @HighTitle
				SET @Done = 1
			ELSE
			BEGIN
--				-- if the new title > the current highest title, set a new highest title, and process the next sponsor
				IF @NewTitle > @HighTitle
				BEGIN
					UPDATE Member SET MaxMembers = @NewTitle WHERE MemberID = @MemberID
				END
				ELSE
				BEGIN	
--					-- get the highest title of all his 1st level affiliates
					SELECT @ChildHighTitle = MAX(MaxMembers) FROM Member WHERE SponsorID = @MemberID AND [Level]=1 AND Status >=1 AND Status <=4
--					-- if the new title < the 1st level highest title, were done
					IF @NewTitle < @ChildHighTitle
						SET @Done = 1
					ELSE
					BEGIN
--						-- if the new title >= the 1st level highest title, set a new highest title, and process the next sponsor
						UPDATE Member SET MaxMembers = @NewTitle WHERE MemberID = @MemberID
					END	
				END
			END
		END
--		-- get out of here
		IF @Done = 1
			SET @MemberID = 0
		ELSE	
		BEGIN
--			-- Set the next sponsor to process		
			SET @MemberID = @SponsorID
--			-- Get the sponsor's info for processing			
			IF @SponsorID > 0
				SELECT @PayTitle = Title, @HighTitle = MaxMembers FROM Member WHERE MemberID = @SponsorID
		END
	END
	ELSE SET @MemberID = 0
END

GO
