-- UPDATE Company 19 Imported Members
------------------------------------------------
--select CompanyID, EnrollDate, Reference, referral, icons, * from Member where CompanyID = 19 order by memberid desc

--Update ReferralIDs
UPDATE me SET ReferralID = re.MemberID
FROM Member AS me JOIN Member AS re ON me.Referral = re.Reference AND re.CompanyID = 19
where me.CompanyID = 19 AND me.Referral <> ''

--Update SponsorIDs
UPDATE me SET SponsorID = sp.MemberID
FROM Member AS me JOIN Member AS sp ON me.Icons = sp.Reference AND sp.CompanyID = 19
where me.CompanyID = 19 AND me.Icons <> ''

--Update MentorID
UPDATE Member SET MentorID = ReferralID WHERE CompanyID = 19

--Update Downline Totals
DECLARE @Result varchar(1000) 
EXEC pts_TellAll_Sales @Result OUTPUT
EXEC pts_TellAll_Sales2 @Result OUTPUT

--Set qualified statuses
DECLARE @Now datetime
SET @Now = GETDATE()
EXEC pts_TellAll_Qualified 1, @Now, @Result OUTPUT
EXEC pts_TellAll_Qualified 2, @Now, @Result OUTPUT

--Set member order options
UPDATE Member SET Options2 = '211' WHERE CompanyID = 19

--Set member order options
UPDATE Member SET Price = 14.99, PaidDate = CAST('10/' + CAST(DAY(EnrollDate) AS VARCHAR(2)) + '/14' AS datetime) WHERE CompanyID = 19

--Create Payout Methods
DECLARE @MemberID int, @ID int, @Name varchar(60), @Reference varchar(20)
DECLARE Member_cursor CURSOR FOR 
SELECT MemberID, NameFirst + ' ' + NameLast, Reference FROM Member
WHERE CompanyID = 19 AND PayID = 0 
OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @Name, @Reference
WHILE @@FETCH_STATUS = 0
BEGIN
	--BillingID,CountryID,TokenType,TokenOwner,Token,Verified,BillingName,Street1,Street2,City,State,Zip
	--PayType int,CommType,CardType,CardNumber,CardMo,CardYr,CardName,CardCode,CheckBank,CheckRoute
	--CheckAccount,CheckAcctType,CheckNumber,CheckName,UpdatedDate,UserID
	EXEC pts_Billing_Add @ID OUTPUT, 224, 0, 0, 0, 0, @Name, '', '', '', '', '', 0, 4, 15, '', 0, 0, @Reference, '', '', '', '', 0, '', '', 0, 1
	UPDATE Member SET PayID = @ID WHERE MemberID = @MemberID
	FETCH NEXT FROM Member_cursor INTO @MemberID, @Name, @Reference
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

