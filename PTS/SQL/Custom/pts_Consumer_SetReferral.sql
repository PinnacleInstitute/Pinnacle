EXEC [dbo].pts_CheckProc 'pts_Consumer_SetReferral'
GO

-- **********************************************
-- Referrals = Personal Referrals
-- Referrals2 = Total Referrals
-- **********************************************
CREATE PROCEDURE [dbo].pts_Consumer_SetReferral
   @ConsumerID int 
AS

SET NOCOUNT ON
DECLARE @MemberID int, @MerchantID int, @ReferID int

SELECT @MemberID = MemberID, @MerchantID = MerchantID, @ReferID = ReferID FROM Consumer WHERE ConsumerID = @ConsumerID

--IF @MemberID > 0
--BEGIN
--	IF @ReferID > 0 
--		UPDATE Member SET Referrals2 = Referrals2 + 1 WHERE MemberID = @MemberID
--	ELSE	
--		UPDATE Member SET Referrals = Referrals + 1, Referrals2 = Referrals2 + 1 WHERE MemberID = @MemberID
--END

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

GO