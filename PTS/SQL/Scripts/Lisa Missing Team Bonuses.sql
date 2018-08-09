--select datepart(ww,commdate), sum(amount) from Commission where OwnerID = 21683 and CommType = 5 
--group by datepart(ww,commdate)
--order by datepart(ww,commdate)

DECLARE @MemberID int, @Total money, @Amount money, @Purpose varchar(30), @PaymentID int, @OwnerID int, @PaidDate datetime
DECLARE @SponsorID int, @Qualify int, @Level int, @cnt int, @Bonus money 

SET @Total = 0

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
select PaymentID, OwnerID, Amount, Purpose, PaidDate from Payment where companyid = 17 and Status = 3 and PaidDate > '4/26/15' and PaidDate < '6/6/15'
and CHARINDEX(Purpose,'202,203,204,205,206,207,208') > 0
order by paiddate
--and paymentid =  86475

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @PaymentID, @MemberID, @Amount, @Purpose, @PaidDate
WHILE @@FETCH_STATUS = 0
BEGIN
	SET @OwnerID = @MemberID
	
	SELECT @MemberID = SponsorID FROM Member WHERE MemberID = @MemberID

	SET @Level = 1
	WHILE @Level <= 10 AND @MemberID > 0
	BEGIN
--		-- Get the Referrer's info
		SET @SponsorID = -1
		SELECT @SponsorID = SponsorID, @Qualify = Qualify FROM Member WHERE MemberID = @MemberID
--Print CAST( @MemberID as varchar(10))

--		--Did we find the member
		IF @SponsorID >= 0
		BEGIN
			-- Check for 2+ personal bonus-qualified Affiliates+	
			SELECT @cnt = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status = 1 AND Title >= 2 
			IF @cnt < 2 SET @Qualify = 0 

--			-- Management Override (top, Bob W., Mike S.)
			IF @MemberID IN (12045,12046,26684,12559,26911,29464,29095) SET @Qualify = 2
			
			IF @Qualify > 1 
			BEGIN
				IF @MemberID = 21683  
				BEGIN
					IF @Purpose = '202' SET @Bonus = 1.5
					IF @Purpose = '203' SET @Bonus = 3.5
					IF @Purpose = '204' SET @Bonus = 7.5
					IF @Purpose = '205' SET @Bonus = 15
					IF @Purpose = '206' SET @Bonus = 30
					IF @Purpose = '207' SET @Bonus = 50
					IF @Purpose = '208' SET @Bonus = 150
				
					SET @Total = @Total + @Bonus
					Print dbo.wtfn_DateOnlyStr(@PaidDate) + ' - ' + CAST( @OwnerID as varchar(10)) + ' - ' + CAST( @Bonus as varchar(10)) + ' - ' + CAST( @Total as varchar(10))
					SET @SponsorID = 0
				END
			END
--				-- move to next level to process (dynamic compression)
			SET @Level = @Level + 1
--			-- Set the memberID to get the next upline Referral
			SET @MemberID = @SponsorID
		END
		ELSE SET @MemberID = 0
	END

	FETCH NEXT FROM Member_cursor INTO @PaymentID, @MemberID, @Amount, @Purpose, @PaidDate
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO
