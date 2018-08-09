EXEC [dbo].pts_CheckProc 'pts_Member_Genealogy'
GO

--EXEC pts_Member_Genealogy 84, 1, 1, 0, 0

CREATE PROCEDURE [dbo].pts_Member_Genealogy
   @MemberID int ,
   @Status int ,
   @Level int ,
   @Title int ,
   @QV money 
AS

SET NOCOUNT ON

DECLARE @Genealogy TABLE(
   MemberID int ,
   SponsorID int ,
   MemberName nvarchar (62),
   EnrollDate datetime,
   VisitDate datetime,
   Status int,
   Title int,
   BV money,
   QV money,
   Phone1 nvarchar (30),
   Email nvarchar (80),
   Identification nvarchar (150)
)

-- Enroller Genealogy
IF @Status = 1
BEGIN
	IF @Level >= 1
	BEGIN
		INSERT INTO @Genealogy
		SELECT A.MemberID, A.ReferralID, A.NameFirst + ' ' + A.NameLast, A.EnrollDate, A.VisitDate, A.Status, 
			A.Title, A.BV, A.QV, A.Phone1, A.Email, ad.City + ', ' + ad.State 
		FROM Member AS A
		LEFT OUTER JOIN Address AS ad ON A.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.ReferralID = @MemberID AND A.Title >= @Title AND A.QV >= @QV AND A.Status >= 1 AND A.Status <= 5 
	END
	IF @Level >= 2
	BEGIN
		INSERT INTO @Genealogy
		SELECT B.MemberID, B.ReferralID, B.NameFirst + ' ' + B.NameLast, B.EnrollDate, B.VisitDate, B.Status, 
			B.Title, B.BV, B.QV, B.Phone1, B.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.ReferralID
		LEFT OUTER JOIN Address AS ad ON B.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.ReferralID = @MemberID AND B.Title >= @Title AND B.QV >= @QV AND B.Status >= 1 AND B.Status <= 5 
	END
	IF @Level >= 3
	BEGIN
		INSERT INTO @Genealogy
		SELECT C.MemberID, C.ReferralID, C.NameFirst + ' ' + C.NameLast, C.EnrollDate, C.VisitDate, C.Status, 
			C.Title, C.BV, C.QV, C.Phone1, C.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.ReferralID
		JOIN Member AS C ON B.MemberID = C.ReferralID
		LEFT OUTER JOIN Address AS ad ON C.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.ReferralID = @MemberID AND C.Title >= @Title AND C.QV >= @QV AND C.Status >= 1 AND C.Status <= 5 
	END
	IF @Level >= 4
	BEGIN
		INSERT INTO @Genealogy
		SELECT D.MemberID, D.ReferralID, D.NameFirst + ' ' + D.NameLast, D.EnrollDate, D.VisitDate, D.Status, 
			D.Title, D.BV, D.QV, D.Phone1, D.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.ReferralID
		JOIN Member AS C ON B.MemberID = C.ReferralID
		JOIN Member AS D ON C.MemberID = D.ReferralID
		LEFT OUTER JOIN Address AS ad ON D.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.ReferralID = @MemberID AND D.Title >= @Title AND D.QV >= @QV AND D.Status >= 1 AND D.Status <= 5 
	END
END
-- Sponsor Genealogy
IF @Status = 2
BEGIN
	IF @Level >= 1
	BEGIN
		INSERT INTO @Genealogy
		SELECT A.MemberID, A.SponsorID, A.NameFirst + ' ' + A.NameLast, A.EnrollDate, A.VisitDate, A.Status, 
			A.Title, A.BV2, A.QV2, A.Phone1, A.Email, ad.City + ', ' + ad.State 
		FROM Member AS A
		LEFT OUTER JOIN Address AS ad ON A.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.SponsorID = @MemberID AND A.Title >= @Title AND A.QV >= @QV AND A.Status >= 1 AND A.Status <= 5 
	END
	IF @Level >= 2
	BEGIN
		INSERT INTO @Genealogy
		SELECT B.MemberID, B.SponsorID, B.NameFirst + ' ' + B.NameLast, B.EnrollDate, B.VisitDate, B.Status, 
			B.Title, B.BV2, B.QV2, B.Phone1, B.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.SponsorID
		LEFT OUTER JOIN Address AS ad ON B.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.SponsorID = @MemberID AND B.Title >= @Title AND B.QV >= @QV AND B.Status >= 1 AND B.Status <= 5 
	END
	IF @Level >= 3
	BEGIN
		INSERT INTO @Genealogy
		SELECT C.MemberID, C.SponsorID, C.NameFirst + ' ' + C.NameLast, C.EnrollDate, C.VisitDate, C.Status, 
			C.Title, C.BV2, C.QV2, C.Phone1, C.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.SponsorID
		JOIN Member AS C ON B.MemberID = C.SponsorID
		LEFT OUTER JOIN Address AS ad ON C.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.SponsorID = @MemberID AND C.Title >= @Title AND C.QV >= @QV AND C.Status >= 1 AND C.Status <= 5 
	END
	IF @Level >= 4
	BEGIN
		INSERT INTO @Genealogy
		SELECT D.MemberID, D.SponsorID, D.NameFirst + ' ' + D.NameLast, D.EnrollDate, D.VisitDate, D.Status, 
			D.Title, D.BV2, D.QV2, D.Phone1, D.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.SponsorID
		JOIN Member AS C ON B.MemberID = C.SponsorID
		JOIN Member AS D ON C.MemberID = D.SponsorID
		LEFT OUTER JOIN Address AS ad ON D.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.SponsorID = @MemberID AND D.Title >= @Title AND D.QV >= @QV AND D.Status >= 1 AND D.Status <= 5 
	END
END
-- Mentor Genealogy
IF @Status = 3
BEGIN
	IF @Level >= 1
	BEGIN
		INSERT INTO @Genealogy
		SELECT A.MemberID, A.MentorID, A.NameFirst + ' ' + A.NameLast, A.EnrollDate, A.VisitDate, A.Status, 
			A.Title, A.BV, A.QV, A.Phone1, A.Email, ad.City + ', ' + ad.State 
		FROM Member AS A
		LEFT OUTER JOIN Address AS ad ON A.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.MentorID = @MemberID AND A.Title >= @Title AND A.QV >= @QV AND A.Status >= 1 AND A.Status <= 5 
	END
	IF @Level >= 2
	BEGIN
		INSERT INTO @Genealogy
		SELECT B.MemberID, B.MentorID, B.NameFirst + ' ' + B.NameLast, B.EnrollDate, B.VisitDate, B.Status, 
			B.Title, B.BV, B.QV, B.Phone1, B.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.MentorID
		LEFT OUTER JOIN Address AS ad ON B.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.MentorID = @MemberID AND B.Title >= @Title AND B.QV >= @QV AND B.Status >= 1 AND B.Status <= 5 
	END
	IF @Level >= 3
	BEGIN
		INSERT INTO @Genealogy
		SELECT C.MemberID, C.MentorID, C.NameFirst + ' ' + C.NameLast, C.EnrollDate, C.VisitDate, C.Status, 
			C.Title, C.BV, C.QV, C.Phone1, C.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.MentorID
		JOIN Member AS C ON B.MemberID = C.MentorID
		LEFT OUTER JOIN Address AS ad ON C.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.MentorID = @MemberID AND C.Title >= @Title AND C.QV >= @QV AND C.Status >= 1 AND C.Status <= 5 
	END
	IF @Level >= 4
	BEGIN
		INSERT INTO @Genealogy
		SELECT D.MemberID, D.MentorID, D.NameFirst + ' ' + D.NameLast, D.EnrollDate, D.VisitDate, D.Status, 
			D.Title, D.BV, D.QV, D.Phone1, D.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.MentorID
		JOIN Member AS C ON B.MemberID = C.MentorID
		JOIN Member AS D ON C.MemberID = D.MentorID
		LEFT OUTER JOIN Address AS ad ON D.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.MentorID = @MemberID AND D.Title >= @Title AND D.QV >= @QV AND D.Status >= 1 AND D.Status <= 5 
	END
END
-- Sponsor2 Genealogy
IF @Status = 4
BEGIN
	IF @Level >= 1
	BEGIN
		INSERT INTO @Genealogy
		SELECT A.MemberID, A.Sponsor2ID, A.NameFirst + ' ' + A.NameLast, A.EnrollDate, A.VisitDate, A.Status, 
			A.Title, A.BV3, A.QV3, A.Phone1, A.Email, ad.City + ', ' + ad.State 
		FROM Member AS A
		LEFT OUTER JOIN Address AS ad ON A.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.Sponsor2ID = @MemberID AND A.Title >= @Title AND A.QV >= @QV AND A.Status >= 1 AND A.Status <= 5 
	END
	IF @Level >= 2
	BEGIN
		INSERT INTO @Genealogy
		SELECT B.MemberID, B.Sponsor2ID, B.NameFirst + ' ' + B.NameLast, B.EnrollDate, B.VisitDate, B.Status, 
			B.Title, B.BV3, B.QV3, B.Phone1, B.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.Sponsor2ID
		LEFT OUTER JOIN Address AS ad ON B.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.Sponsor2ID = @MemberID AND B.Title >= @Title AND B.QV >= @QV AND B.Status >= 1 AND B.Status <= 5 
	END
	IF @Level >= 3
	BEGIN
		INSERT INTO @Genealogy
		SELECT C.MemberID, C.Sponsor2ID, C.NameFirst + ' ' + C.NameLast, C.EnrollDate, C.VisitDate, C.Status, 
			C.Title, C.BV3, C.QV3, C.Phone1, C.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.Sponsor2ID
		JOIN Member AS C ON B.MemberID = C.Sponsor2ID
		LEFT OUTER JOIN Address AS ad ON C.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.Sponsor2ID = @MemberID AND C.Title >= @Title AND C.QV >= @QV AND C.Status >= 1 AND C.Status <= 5 
	END
	IF @Level >= 4
	BEGIN
		INSERT INTO @Genealogy
		SELECT D.MemberID, D.Sponsor2ID, D.NameFirst + ' ' + D.NameLast, D.EnrollDate, D.VisitDate, D.Status, 
			D.Title, D.BV3, D.QV3, D.Phone1, D.Email, ad.City + ', ' + ad.State 
		FROM Member As A
		JOIN Member AS B ON A.MemberID = B.Sponsor2ID
		JOIN Member AS C ON B.MemberID = C.Sponsor2ID
		JOIN Member AS D ON C.MemberID = D.Sponsor2ID
		LEFT OUTER JOIN Address AS ad ON D.MemberID = ad.OwnerID AND ad.OwnerType = 4 AND ad.AddressType = 2 AND ad.IsActive = 1
		WHERE A.Sponsor2ID = @MemberID AND D.Title >= @Title AND D.QV >= @QV AND D.Status >= 1 AND D.Status <= 5 
	END
END

SELECT DISTINCT MemberID, SponsorID, MemberName, EnrollDate, VisitDate, Status, Title, BV, QV, Phone1, Email, Identification
FROM @Genealogy ORDER BY EnrollDate

GO