-- ------------------------------------------------------------------------
-- List and pay bonus Checks
-- ------------------------------------------------------------------------
DECLARE @CompanyID int, @MinCheck money, @ListChecks int, @PayChecks int, @MissingAddress int, @ShowPrivate int, @ShowSummary int 
DECLARE @PaidDate datetime, @BonusDate datetime
-- -----------------------
SET @CompanyID = 582
-- -----------------------
SET @ShowSummary = 1
SET @MissingAddress = 0
SET @ListChecks = 0
SET @PayChecks = 0
SET @ShowPrivate = 0
-- -----------------------
SET @BonusDate = '12/1/08'
SET @MinCheck = 10
SET @PaidDate = '12/15/08'
-- -----------------------

-- show summary of bonus types
IF @ShowSummary != 0
BEGIN
	SELECT CommType, sum(Amount) 'Total'
	FROM BonusItem AS bi
	JOIN Bonus AS bo ON bi.MemberBonusID = bo.BonusID
	WHERE bo.BonusDate = @BonusDate
	GROUP BY CommType
	ORDER BY CommType
END

-- List members with missing active mailing addresses for all members due a bonus check
IF @MissingAddress != 0
BEGIN
	SELECT me.MemberID, me.Namefirst, me.namelast 
	FROM (
		SELECT MemberID, SUM(Total) 'Total' FROM Bonus 
		WHERE CompanyID = @CompanyID AND PaidDate = 0 
		GROUP BY MemberID
		HAVING SUM(Total) >= @MinCheck
	) AS tmp
	JOIN Member AS me ON tmp.MemberID = me.MemberID
	LEFT OUTER JOIN address AS ad ON ( ad.ownertype=4 AND me.memberid = ad.ownerid AND ( ad.addresstype=2) AND ad.IsActive = 1)
	WHERE ad.AddressID IS NULL
	ORDER BY tmp.Total DESC
END

-- List all bonus checks totaling over $10 per member
IF @ListChecks != 0
BEGIN
	SELECT tmp.MemberID, me.Reference, tmp.Total, 
	CASE IsCompany
		WHEN 0 THEN me.NameFirst + ' ' + NameLast 
		WHEN 1 THEN me.CompanyName
	END AS Name, me.email, ad.street1, ad.street2, ad.city, ad.state, ad.zip, co.countryname  
	FROM (
		SELECT MemberID, SUM(Total) 'Total' FROM Bonus 
		WHERE CompanyID = @CompanyID AND PaidDate = 0 
		GROUP BY MemberID
		HAVING SUM(Total) >= @MinCheck
	) AS tmp
	JOIN Member AS me ON tmp.MemberID = me.MemberID
	LEFT OUTER JOIN address AS ad ON ( ad.ownertype=4 AND me.memberid = ad.ownerid AND ( ad.addresstype=2) AND ad.IsActive = 1)
	LEFT OUTER JOIN country AS co ON ad.countryid = co.countryid
	ORDER BY tmp.Total DESC
END

-- mark all bonus checks paid that total $10+ per member
IF @PayChecks != 0
BEGIN
	UPDATE Bonus SET PaidDate = @PaidDate
	WHERE MemberID IN (
		SELECT tmp.MemberID 
		FROM (
			SELECT MemberID, SUM(Total) 'Total' FROM Bonus 
			WHERE CompanyID = @CompanyID AND PaidDate = 0 
			GROUP BY MemberID
			HAVING SUM(Total) >= @MinCheck
		) AS tmp
	)
END

-- show all bonus checks for the selected bonus date
IF @ShowPrivate != 0
BEGIN
	UPDATE Bonus SET IsPrivate = 0 WHERE CompanyID = @CompanyID AND BonusDate = @BonusDate
END
