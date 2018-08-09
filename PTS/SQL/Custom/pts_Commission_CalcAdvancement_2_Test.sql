EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement_2_Test'
GO

--DECLARE @Advance int
--EXEC pts_Commission_CalcAdvancement_2_Test 86214, 1, @Advance output
--print @Advance

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement_2_Test
   @MemberID int,
   @Title int,
   @Advance int OUTPUT
AS

SET NOCOUNT ON
-- *********************************************
-- Check if this agent can advance to this title
-- *********************************************

DECLARE @Count int, @Total int, @Max int

-- Check if member meets the next recruiting requirement
SET @Advance = 0
IF @Title >= 1 AND @Title <=9
BEGIN
--	-- Set the total needed for this title level
	SET @Total = 
	CASE @Title
		WHEN 1 THEN 2
		WHEN 2 THEN 6
		WHEN 3 THEN 10
		WHEN 4 THEN 50
		WHEN 5 THEN 100
		WHEN 6 THEN 500
		WHEN 7 THEN 1000
		WHEN 8 THEN 5000
		WHEN 9 THEN 10000
	END

--	-- Set the total allowed per leg
	SET @Max = @Total / 2

--	-- get the total of all legs with a cap on the max per leg
	SELECT @Count = SUM(
			CASE WHEN QV+(CASE WHEN Status < 5 THEN 1 ELSE 0 END) > @Max 
			THEN @Max ELSE QV+(CASE WHEN Status < 5 THEN 1 ELSE 0 END) END
			) 
	FROM Member WHERE SponsorID = @MemberID

--SELECT namelast, status, QV, QV + (CASE WHEN Status < 5 THEN 1 ELSE 0 END) FROM Member WHERE SponsorID = 86214

--	-- If we got back more than the total, advance the member 
	IF @Count >= @Total
	BEGIN
		IF @Title = 1
		BEGIN
--			-- if title 1, make sure they hae at least 2 legs
			SELECT @Count = BV FROM Member WHERE MemberID = @MemberID
			IF @Count > 1 SET @Advance = 1
		END
		ELSE
			SET @Advance = 1
	END
END
ELSE
	SET @Advance = 1
	
GO
