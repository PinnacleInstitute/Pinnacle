EXEC [dbo].pts_CheckProc 'pts_Downline_Qualify_1'
GO

CREATE PROCEDURE [dbo].pts_Downline_Qualify_1
   @CompanyID int ,
   @MemberID int , 
   @Title int ,
   @Qualified int OUTPUT
AS
-- ***************************************************************
-- Advancement Rquirements - initial value of "Qualified"
-- ---------------------------------------------------------------
-- Qualified = -1 ... first test
-- Qualified = 0 ... looking for promotion
-- Qualified = 1 ... looking for demotion 
-- ***************************************************************
-- Product Codes for advancement requirements
-- ---------------------------------------------------------------
-- RTA ..... RTA Travel Agent Package
-- CTA ..... CTA Travel Agent Package
-- CTAT	.... CTA Training Product
-- CTAU	.... CTA Travel Agent Package Upgrade
-- RCMO	.... RTA / CTA Monthly Subscription
-- EXMO	.... Executive Monthly Subscription
-- TRVL .... Retail Travel (not used for advancement)
-- ***************************************************************

SET NOCOUNT ON
DECLARE @ID int, @Cnt int, @Legs int, @EnrollDate datetime

-- ***************************************************************
-- Qualification for Associate		
-- ***************************************************************
IF @Title = 1
BEGIN
-- 	Cannot Demote, If Qualified = 1, return it unchanged
	IF @Qualified <> 1 
	BEGIN
-- 		Always return qualified
		SET @Qualified = 1
	END
END

-- ***************************************************************
-- Qualification for RTA	
-- ***************************************************************
IF @Title = 2
BEGIN
-- 	Cannot Demote, If Qualified = 1, return it unchanged
	IF @Qualified <> 1 
	BEGIN
		SET @Qualified = 0

-- 		Purchase RTA Travel Agent Package AND 
		EXEC pts_Downline_QualifyProduct @MemberID, 'RTA', @ID OUTPUT 

		IF @ID > 0
		BEGIN
-- 			Purchase RTA / CTA Monthly Subscription
			EXEC pts_Downline_QualifyProduct @MemberID, 'RCMO', @ID OUTPUT 

			IF @ID > 0 SET @Qualified = 1
		END
	END
END

-- ***************************************************************
-- Qualification for CTA
-- ***************************************************************
IF @Title = 3
BEGIN
-- 	Cannot Demote, If Qualified = 1, return it unchanged
	IF @Qualified <> 1 
	BEGIN
		SET @Qualified = 0

--		Purchase RTA / CTA Monthly Subscription AND
		EXEC pts_Downline_QualifyProduct @MemberID, 'RCMO', @ID OUTPUT 

		IF @ID > 0
		BEGIN
-- 			Purchase CTA Travel Agent Package OR
			EXEC pts_Downline_QualifyProduct @MemberID, 'CTA', @ID OUTPUT 

			IF @ID > 0 SET @Qualified = 1

			IF @ID = 0
			BEGIN
--		 		Purchase CTA Training for $50 AND
				EXEC pts_Downline_QualifyProduct @MemberID, 'CTAT', @ID OUTPUT 

				IF @ID > 0
				BEGIN
--		   			Purchase CTA Upgrade Package OR
					EXEC pts_Downline_QualifyProduct @MemberID, 'CTAU', @ID OUTPUT 
	
					IF @ID > 0 SET @Qualified = 1
		
					IF @ID = 0
					BEGIN
--						Get Member's Enroll date
						SELECT @EnrollDate = dbo.wtfn_DateOnly(EnrollDate) FROM Member WHERE MemberID = @MemberID

--						Enroll 2 RTA+ in first 7 days OR
						EXEC pts_Downline_QualifyEnrollee @MemberID, 2, @EnrollDate, 7, @Cnt OUTPUT

						IF @Cnt >= 2  SET @Qualified = 1

						IF @Cnt < 2
						BEGIN
--		     				Enroll 6 RTA+ in first 30 days OR
							EXEC pts_Downline_QualifyEnrollee @MemberID, 2, @EnrollDate, 30, @Cnt OUTPUT
		
							IF @Cnt >= 6  SET @Qualified = 1

							IF @Cnt < 6
							BEGIN
--			     				Enroll 3 RTA+ AND
								EXEC pts_Downline_QualifyEnrollee @MemberID, 2, 0, 0, @Cnt OUTPUT
			
								IF @Cnt >= 3
								BEGIN
--				     				Accumulate 12 downline RTA+ 
									EXEC pts_Downline_QualifyDownline @MemberID, 2, 0, @Cnt OUTPUT, @Legs OUTPUT 

									IF @Cnt >= 12  SET @Qualified = 1
								END
							END
						END
					END
				END
			END
		END
	END
END

-- ***************************************************************
-- Qualification for Executive
-- ***************************************************************
IF @Title = 4
BEGIN
--	Purchase Executive Monthly Subscription AND
	EXEC pts_Downline_QualifyProduct @MemberID, 'EXMO', @ID OUTPUT 

	IF @ID > 0
	BEGIN
--		Don't demote if paying executive monthly fee
		IF @Qualified <> 1
		BEGIN
			SET @Qualified = 0

--			Enroll 1 RTA+
			EXEC pts_Downline_QualifyEnrollee @MemberID, 2, 0, 0, @Cnt OUTPUT
			IF @Cnt >= 1 SET @Qualified = 1
		END
	END
END

-- ***************************************************************
-- Qualification for Regional Executive
-- ***************************************************************
IF @Title = 5
BEGIN
	SET @Qualified = 0

--	Purchase Executive Monthly Subscription AND
	EXEC pts_Downline_QualifyProduct @MemberID, 'EXMO', @ID OUTPUT 

	IF @ID > 0
	BEGIN
--		Enroll 3 CTA+
		EXEC pts_Downline_QualifyEnrollee @MemberID, 3, 0, 0, @Cnt OUTPUT

		IF @Cnt >= 3 SET @Qualified = 1
	END
END

-- ***************************************************************
-- Qualification for National Executive
-- ***************************************************************
IF @Title = 6
BEGIN
	SET @Qualified = 0

--	Purchase Executive Monthly Subscription AND
	EXEC pts_Downline_QualifyProduct @MemberID, 'EXMO', @ID OUTPUT 

	IF @ID > 0
	BEGIN
--		Enroll 8 CTA+ AND
		EXEC pts_Downline_QualifyEnrollee @MemberID, 3, 0, 0, @Cnt OUTPUT

		IF @Cnt >= 8
		BEGIN
--			Build 9 Regional Executives (3 per leg)
			EXEC pts_Downline_QualifyDownline @MemberID, 5, 3, @Cnt OUTPUT, @Legs OUTPUT 

			IF @Cnt >= 9 AND @Legs >= 3 SET @Qualified = 1
		END
	END
END

-- ***************************************************************
-- Qualification for International Executive
-- ***************************************************************
IF @Title = 7
BEGIN
	SET @Qualified = 0

--	Purchase Executive Monthly Subscription AND
	EXEC pts_Downline_QualifyProduct @MemberID, 'EXMO', @ID OUTPUT 

	IF @ID > 0
	BEGIN
--		Enroll 8 CTA+ AND
		EXEC pts_Downline_QualifyEnrollee @MemberID, 3, 0, 0, @Cnt OUTPUT

		IF @Cnt >= 8
		BEGIN
--			Build 9 National Executives (3 per leg)
			EXEC pts_Downline_QualifyDownline @MemberID, 6, 3, @Cnt OUTPUT, @Legs OUTPUT 

			IF @Cnt >= 9 AND @Legs >= 3 SET @Qualified = 1
		END
	END
END

-- ***************************************************************
-- Qualification for Presidential Executive
-- ***************************************************************
IF @Title = 8
BEGIN
	SET @Qualified = 0

--	Purchase Executive Monthly Subscription AND
	EXEC pts_Downline_QualifyProduct @MemberID, 'EXMO', @ID OUTPUT 

	IF @ID > 0
	BEGIN
--		Enroll 25 CTA+ AND
		EXEC pts_Downline_QualifyEnrollee @MemberID, 3, 0, 0, @Cnt OUTPUT

		IF @Cnt >= 8
		BEGIN
--			Build 4 International Executives (1 per leg)
			EXEC pts_Downline_QualifyDownline @MemberID, 7, 1, @Cnt OUTPUT, @Legs OUTPUT 

			IF @Cnt >= 4 AND @Legs >= 4 SET @Qualified = 1
		END
	END
END

GO
