EXEC [dbo].pts_CheckProc 'pts_Member_CalcQV'
GO

--EXEC pts_Member_CalcQV 582

CREATE PROCEDURE [dbo].pts_Member_CalcQV
   @CompanyID int 
AS

SET NOCOUNT ON

-- *********************************************************************************
IF @CompanyID = 582
BEGIN
-- *********************************************************************************

DECLARE @MemberID int, @BV money, @SponsorID int, @IDS varchar(8000), @IDSTR varchar(10)  

-- --------------------------------------------------------------------------------------------------------
-- calculate the member's total group points (QV) by accumulating the downline BV
-- --------------------------------------------------------------------------------------------------------
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, BV
FROM Member WHERE CompanyID = @CompanyID AND Status = 1 AND BV != 0

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV

WHILE @@FETCH_STATUS = 0
BEGIN
--	-- walk up the sponsor line and increment their Member group points (QV)
	SET @IDS = ','
	SET @SponsorID = 1
	WHILE @SponsorID != 0
	BEGIN
		SELECT @SponsorID = ISNULL(SponsorID,0) FROM Member Where MemberID = @MemberID
		IF @SponsorID != 0
		BEGIN
--			-- check if we already processed this SponsorID (stuck in a loop)
			SET @IDSTR = CAST(@SponsorID AS VARCHAR(10))
			IF CHARINDEX( ',' + @IDSTR + ',', @IDS ) = 0
			BEGIN
				UPDATE Member SET QV = QV + @BV WHERE MemberID = @SponsorID
				SET @MemberID = @SponsorID
				IF LEN( @IDS + @IDSTR + ',' ) < 8000
					SET @IDS = @IDS + @IDSTR + ','
				ELSE
					SET @SponsorID = 0
			END
			ELSE
			BEGIN
				SET @SponsorID = 0
			END
		END
	END
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @BV
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor


END

GO