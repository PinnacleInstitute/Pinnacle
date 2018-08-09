EXEC [dbo].pts_CheckProc 'pts_Company_Referrals'
GO

CREATE PROCEDURE [dbo].pts_Company_Referrals
   @CompanyID int,
   @References varchar(2000),
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @x int, @y int, @Refs varchar(31), @Ref1 varchar(15), @Ref2 varchar(15)
DECLARE @id1 int, @id2 int

SET @Count = 0

WHILE @References != ''
BEGIN
--	Get Each pair of references
	SET @x = CHARINDEX(';', @References)
	IF @x > 0
	BEGIN
		SET @Refs = SUBSTRING(@References, 1, @x-1)
		SET @References = SUBSTRING(@References, @x+1, LEN(@References)-@x) 
	END
	ELSE
	BEGIN
		SET @Refs = @References
		SET @References = ''
	END
--	Get the two separate references
	SET @y = CHARINDEX(' ', @Refs)
	IF @y = 0
		SET @y = CHARINDEX(',', @Refs)
	IF @y > 0
	BEGIN
		SET @Ref1 = LTRIM(RTRIM(SUBSTRING(@Refs, 1, @y-1)))
		SET @Ref2 = LTRIM(RTRIM(SUBSTRING(@Refs, @y+1,LEN(@Refs)-@y)))
		IF @Ref1 != '' AND @Ref2 != ''
		BEGIN
			UPDATE Member SET Referral = @Ref2 WHERE CompanyID = @CompanyID AND Reference = @Ref1
			SET @Count = @Count + 1

--			SET @id1 = 0
--			SET @id2 = 0
--			SELECT @id1 = ISNULL(MemberID,0) FROM Member WHERE CompanyID = @CompanyID AND Reference = @Ref1
--			IF @id1 > 0
--				SELECT @id2 = ISNULL(MemberID,0) FROM Member WHERE CompanyID = @CompanyID AND Reference = @Ref2
--			IF @id1 > 0 AND @id2 > 0
--			BEGIN
--				SET @Count = @Count + 1
--				UPDATE Member SET ReferralID = @id2 WHERE MemberID = @id1
--			END
		END
	END
END 

GO