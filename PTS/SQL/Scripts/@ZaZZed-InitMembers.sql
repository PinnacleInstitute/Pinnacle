-- *******************************************************************
-- Initialize All ZaZZed Members 
-- *******************************************************************
DECLARE @CompanyID int, @MemberID int, @ReferralID int, @Result varchar(1000), @cnt int
SET @CompanyID = 9

--	Clear titles, Sponsor2ID
--UPDATE Member SET Title = 0, Title2 = 0, Sponsor2ID = 0 WHERE CompanyID = @CompanyID
UPDATE Member SET Sponsor2ID = 0 WHERE CompanyID = @CompanyID

--	Process all members starting with the first entered
DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, ReferralID
FROM Member 
WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4
ORDER BY EnrollDate

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_ZaZZed_Placement @MemberID, @Result output
	
--	DELETE MemberTitle Where MemberID = @MemberID

--	EXEC pts_Commission_CalcAdvancement_9 @ReferralID, @cnt OUTPUT
	
	FETCH NEXT FROM Member_cursor INTO @MemberID, @ReferralID
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO