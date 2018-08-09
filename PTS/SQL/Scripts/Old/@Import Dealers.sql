-- ********************************************************************************************************
-- IMPORT DEALERS
-- 1. INSERT Members  (Member1.xsl, Member2.xsl)
-- 2. UPDATE Member Defaults  (script below)
-- 3. UPDATE Member Status & Level (script below)
-- 4. UPDATE Member IsCompany  (script below)
-- 5. Update Member Referral  (Memberlineage1.xsl, Memberlineage2.xsl)
-- 6. Update Member ReferralID  (script below)
-- 7. Create AuthUser Record  (script below)
-- 8. INSERT Memberes  (Member1.xsl, Member2.xsl, Member3.xsl)
-- 9. Update Member Owner  (script below)
-- 10. Update Member Type  (Membertype1.xsl, Membertype2.xsl, Membertype3.xsl ) 
-- 11. Cleanup bad/employee Dealers, orphan Memberes
-- ********************************************************************************************************

--INSERT INTO Member ( CompanyID, NameFirst, NameLast, TaxIDType, TaxID, Email, CompanyName, Phone1, Phone2, Fax, Reference, EnrollDate, Referral ) VALUES ( 582, 'Roland', 'Franceschi', 2, '650208568', ' rollief@comcast.net', '', '', '9529356714', '', '110', '6/21/1988', '' )
--SELECT TOP 1 * FROM Member ORDER BY MemberID DESC
--SELECT TOP 1 * FROM AuthUser ORDER BY AuthUserID DESC
--UPDATE Member SET Reference = '100', CompanyID = 13 WHERE MemberID = 881

-- ********************************************************************************************************
-- SET Default Member Fields 
-- ********************************************************************************************************
UPDATE Member SET
Signature = NameFirst + ' ' + NameLast + '<BR>' + Email + '<BR>' + Phone1,
NotifyMentor = 'ABCDEF',
Icons = 'G2HEK'
WHERE CompanyID = 582 and MemberID > 75126

-- ********************************************************************************************************
-- SET Member Status & Level
-- ********************************************************************************************************
-- Update Distributors
UPDATE Member SET Status = 1, Level = 1
WHERE Status = 0 AND Level = 1 AND CompanyID = 582 and MemberID > 75126
-- Update Customers 
UPDATE Member SET Status = 3, Level = 0
WHERE Status = 1 AND Level = 2 AND CompanyID = 582 and MemberID > 75126

-- ********************************************************************************************************
-- SET IsCompany & CompanyName
-- ********************************************************************************************************
UPDATE Member SET IsCompany = 1 WHERE LEN(CompanyName) > 0 AND CompanyID = 582 and MemberID > 75126
UPDATE Member SET CompanyName = NameLast + ', ' + NameFirst WHERE IsCompany = 0 AND CompanyID = 582 and MemberID > 75126

-- ********************************************************************************************************
-- Update Referral ID
-- ********************************************************************************************************

UPDATE me
SET me.ReferralID = sp.MemberID
FROM Member AS me
JOIN Member as sp ON me.Referral = sp.Reference and sp.companyid=582
WHERE me.CompanyID = 582 AND me.ReferralID = 0

UPDATE me
SET me.SponsorID = sp.MemberID, me.MentorID = sp.MemberID
FROM Member AS me
JOIN Member as sp ON me.Role = sp.Reference and sp.companyid=582
WHERE me.CompanyID = 582 AND me.ReferralID = 0

-- ********************************************************************************************************
-- Create AuthUser Record 
-- ********************************************************************************************************
DECLARE @MemberID int, @NameFirst varchar(30), @NameLast varchar(30), @Email varchar(80), @Reference varchar(15), @Referral varchar(15)
DECLARE @AuthUserID int, @IsAvailable bit

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, NameFirst, NameLast, Email, Reference, Referral 
FROM Member WHERE CompanyID = 582 AND AuthUserID = 0 and MemberID > 75126

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @NameFirst, @NameLast, @Email, @Reference, @Referral

WHILE @@FETCH_STATUS = 0
BEGIN
	IF @Referral = '' SET @Referral = 'eco'

	IF @Reference != '' EXEC pts_AuthUser_IsLogon @Reference, @IsAvailable OUTPUT
	IF @IsAvailable = 0 SET @Reference = ''

	EXEC pts_AuthUser_Add @Reference, @Referral, @Email, @NameLast, @NameFirst, 41, 1, 1, @AuthUserID OUTPUT

	UPDATE Member SET AuthUserID = @AuthUserID, Referral = '' WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @NameFirst, @NameLast, @Email, @Reference, @Referral
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

-- ********************************************************************************************************
-- Update Member Owner
-- ADD Reference text 15, tmpid int
-- Delete Reference, tmpid when done
-- ********************************************************************************************************
--INSERT INTO Member ( CountryID, Street1, Street2, City, State, Zip, Reference, tmpid ) VALUES ( 224, '%Edward Jones,Att: Dean L', '2145 Woodlane Dr.Suite103', 'Woodbury', 'MN', '55125', '100', 1 )
-- UPDATE Member SET MemberType = 4 WHERE tmpid = 1
-- select top 1 * from Member order by Memberid desc
UPDATE ad
SET ad.OwnerType = 4, ad.OwnerID = me.MemberID
FROM Member AS ad
JOIN Member as me ON ad.Reference = me.Reference
WHERE ad.OwnerType = 0

-- ********************************************************************************************************
-- Populate Member Referral/Enroller and Role/Sponsor from Sponsor Table 
-- ********************************************************************************************************
DECLARE @MemberID int, @Reference varchar(15), @Sponsor varchar(10), @Enroller varchar(10)
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Reference
FROM Member WHERE CompanyID = 582 AND Referral = ''

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Reference

WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @Sponsor = Sponsor, @Enroller = Enroller FROM Sponsor WHERE Dealer = @Reference

	UPDATE Member SET Referral = @Enroller, Role = @Sponsor WHERE MemberID = @MemberID

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Reference
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

-- ********************************************************************************************************
-- Lookup Sponsor from Sponsor Table 
-- ********************************************************************************************************
DECLARE @MemberID int, @Role varchar(15), @Sponsor varchar(10), @SponsorID int, @Good int
DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Role
FROM Member WHERE CompanyID = 582 AND SponsorID = 0 and Role != ''

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Role

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Good = 1
	WHILE @Good = 1
	BEGIN
		SET @Sponsor = ''
		SELECT @Sponsor = Sponsor FROM Sponsor WHERE Dealer = @Role
		IF @Sponsor != ''
		BEGIN		
			SET @SponsorID = 0
			SELECT @SponsorID = MemberID FROM Member WHERE CompanyID = 582 AND Reference = @Sponsor
			IF @SponsorID != 0
			BEGIN
				UPDATE Member SET SponsorID = @SponsorID WHERE MemberID = @MemberID
				SET @Good = 0
			END
			ELSE
				SET @Role = @Sponsor
		END
		ELSE
			SET @Good = 0
	END

	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Role
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

-- ********************************************************************************************************
-- Set Active Addresss
-- ********************************************************************************************************
DECLARE @AddressID int, @OwnerType int, @OwnerID int, @AddressType int, @CopyID int
DECLARE Address_Cursor CURSOR LOCAL STATIC FOR 
SELECT AddressID, OwnerType, OwnerID, AddressType
FROM Address WHERE AddressID >= 181048
OPEN Address_Cursor
FETCH NEXT FROM Address_Cursor INTO @AddressID, @OwnerType, @OwnerID, @AddressType

WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_Address_Activate @OwnerType, @OwnerID, @AddressType, @AddressID, @CopyID

	FETCH NEXT FROM Address_Cursor INTO @AddressID, @OwnerType, @OwnerID, @AddressType
END
CLOSE Address_Cursor
DEALLOCATE Address_Cursor

--select * from member where companyid = 582 and sponsorid = 0
--select * from member where companyid = 582 and referralid = 0
