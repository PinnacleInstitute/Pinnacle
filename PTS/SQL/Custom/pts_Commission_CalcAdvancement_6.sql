EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_6'
GO

--DECLARE @Count int
--EXEC pts_Commission_CalcAdvancement_6 0, @Count OUTPUT
--PRINT @Count

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_6
   @OwnerID int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Total int, @Title int, @MemberID int, @SponsorID int, @ReferralID int
DECLARE @Now datetime, @cnt int, @Personal int
SET @CompanyID = 6
SET @Now = GETDATE()

-- If OwnerID is specified, we only calculate this one member
IF @OwnerID > 0
BEGIN
	DECLARE @AdvanceID int, @curTitle int, @Title1 int, @Title2 int, @Title3 int, @Title4 int, @IsLocked bit
	SET @MemberID = @OwnerID
	SET @Title = 1
	SET @AdvanceID = 0

	SELECT @AdvanceID = AdvanceID, @curTitle = Title, @Personal = Personal, 
	@Title1 = Title1, @Title2 = Title2, @Title3 = Title3, @Title4 = Title4, @IsLocked = IsLocked
	FROM Advance WHERE MemberID = @MemberID

	IF @AdvanceID > 0
	BEGIN	
		IF @Personal >= 3 AND @Title1 >= 12 SET @Title = 2
		IF @Personal >= 5 AND @Title2 >= 10 SET @Title = 3
		IF @Personal >= 8 AND @Title3 >= 10 SET @Title = 4

--		-- profcess new title if it changed and ( its not locked or its a higher title )
		IF @Title > @curTitle AND ( @IsLocked = 0 OR @Title > @curTitle )
		BEGIN
			DECLARE @oldTitle int, @newTitle int

			SELECT @oldTitle = Title FROM Member WHERE MemberID = @MemberID
					
			UPDATE Advance SET Title = @Title WHERE MemberID = @MemberID
			EXEC pts_Advance_UpdateTitle @MemberID, @Count OUTPUT

--			-- get the member's newly stored title
			SELECT @newTitle = Title, @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID
		
--			-- the member's title changed, update the upline title counts
			IF @oldTitle != @newTitle
			BEGIN
				WHILE @ReferralID > 0
				BEGIN
					IF @newTitle = 1 UPDATE Advance SET Title1 = Title1 + 1 WHERE MemberID = @ReferralID
					IF @newTitle = 2 UPDATE Advance SET Title2 = Title2 + 1 WHERE MemberID = @ReferralID
					IF @newTitle = 3 UPDATE Advance SET Title3 = Title3 + 1 WHERE MemberID = @ReferralID
					IF @newTitle = 4 UPDATE Advance SET Title4 = Title4 + 1 WHERE MemberID = @ReferralID
					IF @oldTitle = 1 UPDATE Advance SET Title1 = Title1 - 1 WHERE MemberID = @ReferralID
					IF @oldTitle = 2 UPDATE Advance SET Title2 = Title2 - 1 WHERE MemberID = @ReferralID
					IF @oldTitle = 3 UPDATE Advance SET Title3 = Title3 - 1 WHERE MemberID = @ReferralID
					IF @oldTitle = 4 UPDATE Advance SET Title4 = Title4 - 1 WHERE MemberID = @ReferralID

					SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @ReferralID
				END
			END	
		END	
	END
END
ELSE
BEGIN

--	-- *********************************************************
--	-- Initialize all Company Advance records
--	-- *********************************************************
	UPDATE ad SET Title1 = 0, ad.Title2 = 0, Title3 = 0, Title4 = 0 
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Create Advance records for Affiliates that don't have them
--	-- *********************************************************
	INSERT INTO Advance ( MemberID ) 
		SELECT me.MemberID FROM Member AS me
		LEFT OUTER JOIN Advance AS ad ON me.MemberID = ad.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status > 0
		AND ad.MemberID IS NULL

--	-- *********************************************************
--	-- Copy title, personal (BV) and group (QV) numbers to Member's Advance record
--	-- *********************************************************
	UPDATE ad SET Title = 1, Personal = me.BV, [Group] = me.QV, Title1 = me.QV
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Copy locked titles
--	-- *********************************************************
	UPDATE ad SET Title = me.Title, IsLocked = 1
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID
	AND me.MinTitle > 0 AND ( me.TitleDate = 0 OR me.TitleDate > @Now )

--	-- *********************************************************
--	-- Calculate qualified Managers and above
--	-- *********************************************************
	UPDATE ad SET Title = 2
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID AND ad.Personal >= 3 AND ad.Title1 >= 12
	AND ( ad.Islocked = 0 OR ad.Title < 2 )

--	-- *********************************************************
--	-- Get the number of direct managers for each member and initialize Process for processing
--	-- *********************************************************
	UPDATE ad SET Process = ( 
		SELECT COUNT(*) FROM Member AS mm JOIN Advance AS av ON mm.MemberID = av.MemberID
		WHERE mm.SponsorID = me.MemberID AND mm.Status >= 1 AND mm.Status <= 4 AND av.Title >= 2 ) 
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Accumulate number of downline Managers for each Affiliate
--	-- Process all members at the bottom of the hierarchy (BV=0 they have no recruits)
--	-- *********************************************************
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT SponsorID FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV = 0

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Total = 0
		WHILE @MemberID > 0
		BEGIN
--			-- Get the current Member's Manager count and sponsor
			SET @AdvanceID = 0 SET @cnt = 0 SET @Personal = 0 SET @SponsorID = 0 
			SELECT @AdvanceID = ad.AdvanceID, @cnt = ad.Title2, @Personal = ad.Process, @SponsorID = me.SponsorID 
			FROM Member AS me LEFT OUTER JOIN Advance AS ad ON me.MemberID = ad.MemberID
			WHERE me.MemberID = @MemberID

--			-- If first time processing this member, accumulate the manager count
			IF @cnt = 0 SET @Total = @Total + @Personal

--			-- Add the total to the existing group 
			IF @AdvanceID > 0 AND @Total > 0
				UPDATE Advance SET Title2 = Title2 + @Total, Process = 0 WHERE MemberID = @MemberID

--			-- setup for the next upline referrer
			SET @MemberID = @SponsorID
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

--	-- *********************************************************
--	-- Calculate qualified Directors and above
--	-- *********************************************************
	UPDATE ad SET Title = 3
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID AND ad.Personal >= 5 AND ad.Title2 >= 10
	AND ( ad.Islocked = 0 OR ad.Title < 3 )

--	-- *********************************************************
--	-- Get the number of direct directors for each member and initialize Process for processing
--	-- *********************************************************
	UPDATE ad SET Process = ( 
		SELECT COUNT(*) FROM Member AS mm JOIN Advance AS av ON mm.MemberID = av.MemberID
		WHERE mm.SponsorID = me.MemberID AND mm.Status >= 1 AND mm.Status <= 4 AND av.Title >= 3 ) 
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Accumulate number of downline Directors for each Affiliate
--	-- Process all members at the bottom of the hierarchy (BV=0 they have no recruits)
--	-- *********************************************************
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT SponsorID FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV = 0

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Total = 0
		WHILE @MemberID > 0
		BEGIN
--			-- Get the current Member's director count and sponsor
			SET @AdvanceID = 0 SET @cnt = 0 SET @Personal = 0 SET @SponsorID = 0 
			SELECT @AdvanceID = ad.AdvanceID, @cnt = ad.Title3, @Personal = ad.Process, @SponsorID = me.SponsorID 
			FROM Member AS me LEFT OUTER JOIN Advance AS ad ON me.MemberID = ad.MemberID
			WHERE me.MemberID = @MemberID

--			-- If first time processing this member, accumulate the manager count
			IF @cnt = 0 SET @Total = @Total + @Personal

--			-- Add the total to the existing group 
			IF @AdvanceID > 0 AND @Total > 0
				UPDATE Advance SET Title3 = Title3 + @Total, Process = 0 WHERE MemberID = @MemberID

--			-- setup for the next upline sponsor
			SET @MemberID = @SponsorID
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

--	-- *********************************************************
--	-- Calculate qualified National Directors
--	-- *********************************************************
	UPDATE ad SET Title = 4
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID AND ad.Personal >= 8 AND ad.Title3 >= 10 
	AND ( ad.Islocked = 0 OR ad.Title < 4 )

--	-- *********************************************************
--	-- Get the number of direct national directors for each member and initialize Process for processing
--	-- *********************************************************
	UPDATE ad SET Process = ( 
		SELECT COUNT(*) FROM Member AS mm JOIN Advance AS av ON mm.MemberID = av.MemberID
		WHERE mm.SponsorID = me.MemberID AND mm.Status >= 1 AND mm.Status <= 4 AND av.Title >= 4 ) 
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Accumulate number of downline National Directors for each Affiliate
--	-- Process all members at the bottom of the hierarchy (BV=0 they have no recruits)
--	-- *********************************************************
	DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
	SELECT SponsorID FROM Member 
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4 AND BV = 0

	OPEN Member_cursor
	FETCH NEXT FROM Member_cursor INTO @MemberID
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @Total = 0
		WHILE @MemberID > 0
		BEGIN
--			-- Get the current Member's national director count and sponsor
			SET @AdvanceID = 0 SET @cnt = 0 SET @Personal = 0 SET @SponsorID = 0 
			SELECT @AdvanceID = ad.AdvanceID, @cnt = ad.Title4, @Personal = ad.Process, @SponsorID = me.SponsorID 
			FROM Member AS me LEFT OUTER JOIN Advance AS ad ON me.MemberID = ad.MemberID
			WHERE me.MemberID = @MemberID

--			-- If first time processing this member, accumulate the manager count
			IF @cnt = 0 SET @Total = @Total + @Personal

--			-- Add the total to the existing group 
			IF @AdvanceID > 0 AND @Total > 0
				UPDATE Advance SET Title4 = Title4 + @Total, Process = 0 WHERE MemberID = @MemberID

--			-- setup for the next upline sponsor
			SET @MemberID = @SponsorID
		END
		FETCH NEXT FROM Member_cursor INTO @MemberID
	END
	CLOSE Member_cursor
	DEALLOCATE Member_cursor

--	-- *********************************************************
--	-- Adjust title counts to be actual counts and not accumulated
--	-- *********************************************************
	UPDATE ad SET 
		ad.Title1 = ad.Title1 - ad.Title2,
		ad.Title2 = ad.Title2 - ad.Title3,
		ad.Title3 = ad.Title3 - ad.Title4 
	FROM Advance AS ad JOIN Member AS me ON ad.MemberID = me.MemberID 
	WHERE me.CompanyID = @CompanyID

--	-- *********************************************************
--	-- Update the member's title and title history, if their title has changed
--	-- *********************************************************
	EXEC pts_Advance_UpdateTitle 0, @Count OUTPUT
END
