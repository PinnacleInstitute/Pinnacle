EXEC [dbo].pts_CheckProc 'pts_Consumer_SetReferrals'
GO

-- **********************************************
-- Referral = Personal Referrals
-- Referral2 = Total Referrals
-- **********************************************
CREATE PROCEDURE [dbo].pts_Consumer_SetReferrals
   @CompanyID int 
AS

SET NOCOUNT ON

-- Clear Referral Stats
--UPDATE Member SET Referrals = 0, Referrals2 = 0 WHERE CompanyID = @CompanyID AND (Referrals > 0 OR Referrals2 > 0)
UPDATE Merchant SET Referrals = 0, Referrals2 = 0 WHERE Referrals > 0 OR Referrals2 > 0

DECLARE @ConsumerID int, @MemberID int, @MerchantID int, @ReferID int

DECLARE Consumer_Cursor CURSOR LOCAL STATIC FOR 
SELECT ConsumerID, MemberID, MerchantID, ReferID FROM Consumer

OPEN Consumer_Cursor
FETCH NEXT FROM Consumer_Cursor INTO @ConsumerID, @MemberID, @MerchantID, @ReferID

WHILE @@FETCH_STATUS = 0
BEGIN
--	IF @MemberID > 0
--	BEGIN
--		IF @ReferID > 0 
--			UPDATE Member SET Referrals2 = Referrals2 + 1 WHERE MemberID = @MemberID
--		ELSE	
--			UPDATE Member SET Referrals = Referrals + 1, Referrals2 = Referrals2 + 1 WHERE MemberID = @MemberID
--	END

	IF @MerchantID > 0
	BEGIN
		IF @ReferID > 0 
			UPDATE Merchant SET Referrals2 = Referrals2 + 1 WHERE MerchantID = @MerchantID 
		ELSE	
			UPDATE Merchant SET Referrals = Referrals + 1, Referrals2 = Referrals2 + 1 WHERE MerchantID = @MerchantID
	END
	
	IF @ReferID > 0 
	BEGIN
		UPDATE Consumer SET Referrals = Referrals + 1 WHERE ConsumerID = @ReferID
	END	

	FETCH NEXT FROM Consumer_Cursor INTO @ConsumerID, @MemberID, @MerchantID, @ReferID
END
CLOSE Consumer_Cursor
DEALLOCATE Consumer_Cursor



GO