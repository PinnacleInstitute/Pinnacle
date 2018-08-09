EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_21'
GO

--EXEC pts_Member_CustomList_21 108, 0

CREATE PROCEDURE [dbo].pts_Member_CustomList_21
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int, @ListDate datetime
SET @CompanyID = 21

-- Get All Member List with missing Wallets
IF @Status = 105
BEGIN
	Select me.MemberID 'MemberID', me.Status 'Status', me.Level 'Level', 
	CAST(me.MemberID AS VARCHAR(10)) + ' ' + CAST(me.NameFirst AS VARCHAR(30)) + ' ' + CAST(me.NameLast AS VARCHAR(30)) AS 'Signature' 
	FROM Member AS me
	WHERE me.CompanyID = @CompanyID	AND me.Status < 5 AND Reference = ''
	ORDER BY me.EnrollDate DESC
END

-- Get All Member List with order errors
IF @Status = 106
BEGIN
	Select pa.PaymentID 'MemberID', me.Status AS 'Status', me.MemberID 'Level',
	me.NameFirst + ' ' + me.NameLast  + ' - #' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.email + ' - ' + CAST(pa.amount AS VARCHAR(10)) + ' - ' + CAST(pa.paydate AS VARCHAR(30)) + ' - ' + CAST(pa.notes AS VARCHAR(500)) AS 'Signature' 
	FROM Payment AS pa
	JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing = 3 AND pa.Status = 3
	AND pa.PaidDate > '1/1/15'
	AND Purpose IN ('103','104','105','106','107','108','203','204','205','206','207','208')
	AND (Notes like '%ERROR%' OR Notes like '%GCRORDER: %' OR Notes not like '%GCRORDER:%') 
	
	ORDER BY pa.PaidDate DESC, pa.PaymentID DESC
END

--	Get sponsor orphaned members
IF @Status = 107
BEGIN
	Select me.MemberID, me.SponsorID AS 'Status', 0 AS 'Level', 
	me.NameFirst + ' ' + me.NameLast AS 'Signature' 
	FROM Member AS me
	LEFT OUTER JOIN Member AS sp ON me.SponsorID = sp.MemberID
	WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.SponsorID = 0
	AND ( sp.MemberID IS NULL OR sp.Status > 5 )
	AND me.MemberID <> 12045
	ORDER BY me.EnrollDate
END

-- Data Exceptions List
IF @Status = 200
BEGIN
	DECLARE @Exception TABLE(MemberID int, Status int, Level int, Name nvarchar(100), Msg nvarchar(200) )

	IF @Level = 1 -- Sales Team Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Active Enroller' 
		FROM Member AS me JOIN Member as re ON me.ReferralID = re.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND re.Status > 4

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Member Enrolled to Himself' 
		FROM Member AS me
		WHERE me.CompanyID = @CompanyID AND me.Status >= 1 AND me.Status <= 4 AND me.ReferralID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Member Matrix to Himself' 
		FROM Member AS me
		WHERE me.CompanyID = @CompanyID AND me.SponsorID > 0 AND me.SponsorID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Parent Enroller Loop' 
		FROM Member AS me 
		JOIN Member as re ON me.ReferralID = re.MemberID
		WHERE me.CompanyID = @CompanyID AND re.ReferralID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Parent Matrix Loop' 
		FROM Member AS me 
		JOIN Member as sp ON me.SponsorID = sp.MemberID
		WHERE me.CompanyID = @CompanyID AND me.SponsorID > 0 AND sp.SponsorID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Grandparent Enroller Loop' 
		FROM Member AS me 
		JOIN Member as re ON me.ReferralID = re.MemberID
		JOIN Member as re2 ON re.ReferralID = re2.MemberID
		WHERE me.CompanyID = @CompanyID AND re2.ReferralID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Grandparent Matrix Loop' 
		FROM Member AS me 
		JOIN Member as sp ON me.SponsorID = sp.MemberID
		JOIN Member as sp2 ON sp.SponsorID = sp2.MemberID
		WHERE me.CompanyID = @CompanyID AND me.SponsorID > 0 AND sp2.SponsorID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Great Grandparent Enroller Loop' 
		FROM Member AS me 
		JOIN Member as re ON me.ReferralID = re.MemberID
		JOIN Member as re2 ON re.ReferralID = re2.MemberID
		JOIN Member as re3 ON re2.ReferralID = re3.MemberID
		WHERE me.CompanyID = @CompanyID AND re3.ReferralID = me.MemberID

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Great Grandparent Matrix Loop' 
		FROM Member AS me 
		JOIN Member as sp ON me.SponsorID = sp.MemberID
		JOIN Member as sp2 ON sp.SponsorID = sp2.MemberID
		JOIN Member as sp3 ON sp2.SponsorID = sp3.MemberID
		WHERE me.CompanyID = @CompanyID AND me.SponsorID > 0 AND sp3.SponsorID = me.MemberID
	END
	
	IF @Level = 2 -- Billing Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Autoship Price' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing IN (3,5) AND me.Price = 0
		AND (Options2 LIKE '%101%' OR Options2 LIKE '%102%' OR Options2 LIKE '%103%' OR Options2 LIKE '%20%') 

		INSERT INTO @Exception
		Select me.MemberID, 2, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Missing Autoship Code' 
		FROM Member AS me WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND me.Billing IN (3,5) AND me.Price > 0
		AND (Options2 NOT LIKE '%101%' AND Options2 NOT LIKE '%102%' AND Options2 NOT LIKE '%103%' AND Options2 NOT LIKE '%20%')
	END	

	IF @Level = 3 -- Order Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Non-Approved Payment with Paid Commissions' 
		FROM Payment AS pa 
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND pa.Status <> 3 AND pa.CommStatus = 2 
		AND Notes NOT LIKE '%Wrong%' -- skip these special cases 

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Approved Payment with No Commissions' 
		FROM Payment AS pa 
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND pa.Status = 3 AND pa.CommStatus = 1 

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Pending Payment Over 2 Days: ' + pa.Notes
		FROM Payment AS pa 
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND pa.Status = 2 AND DATEDIFF(d,pa.PaidDate, GETDATE()) >= 2 
	END	

	IF @Level = 4 -- Wallet Exceptions
	BEGIN
		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Transfer Credit Without a Debit: ' + dbo.wtfn_DateOnlyStr(pa.PayDate) + ' - ' + CAST(pa.Amount AS VARCHAR(10)) + ' - ' + pa.Reference
		FROM Payout AS pa 
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND pa.status IN (1,2) AND pa.Paytype = 92 AND pa.Amount > 0
		AND 0 = (SELECT Count(*) FROM Payout WHERE OwnerType = 4 AND CAST(OwnerID AS VARCHAR(10)) = pa.Reference AND PayType = 92 AND PayDate = pa.PayDate AND ABS(Amount) = ABS(pa.Amount))		

		INSERT INTO @Exception
		Select me.MemberID, 1, me.Title, '#' + CAST(me.MemberID AS VARCHAR(10)) + ' - ' + me.NameFirst + ' ' + me.NameLast, 'Transfer Debit Without a Credit: ' + dbo.wtfn_DateOnlyStr(pa.PayDate) + ' - ' + CAST(pa.Amount AS VARCHAR(10)) + ' - ' + pa.Reference
		FROM Payout AS pa 
		JOIN Member AS me ON pa.OwnerType = 4 AND pa.OwnerID = me.MemberID
		WHERE me.CompanyID = @CompanyID AND me.Status = 1 AND pa.status IN (1,2) AND pa.Paytype = 92 AND pa.Amount < 0
		AND 0 = (SELECT Count(*) FROM Payout WHERE OwnerType = 4 AND CAST(OwnerID AS VARCHAR(10)) = LEFT(pa.Reference,5) AND PayType = 92 AND PayDate = pa.PayDate AND ABS(Amount) = ABS(pa.Amount))		
	END	

--	Handle Members in results more than once.
	UPDATE ex SET Msg = Msg + '.....' FROM @Exception AS ex WHERE 1 < ( SELECT COUNT(*) FROM @Exception WHERE MemberID = ex.MemberID )
		
	SELECT MemberID, MIN(Status)'Status', MIN(Level)'Level', MIN(Name + ' - ' + Msg) 'Signature'  FROM @Exception	GROUP BY MemberID ORDER BY Status, Level DESC

END


GO
