EXEC [dbo].pts_CheckProc 'pts_Company_ReferralIDs'
GO

CREATE PROCEDURE [dbo].pts_Company_ReferralIDs
   @CompanyID int,
   @Count int OUTPUT
AS

SET NOCOUNT ON
SET @Count = 0

DECLARE @MemberID int, @RefID int, @ReferralID int, @Referral nvarchar(15)

DECLARE Member_cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, CompanyID, ReferralID, Referral FROM Member
WHERE (@CompanyID = 0 OR CompanyID = @CompanyID)
AND IsDiscount = 1
AND ReferralID = 0
AND Referral != ''

OPEN Member_cursor
FETCH NEXT FROM Member_cursor INTO @MemberID, @CompanyID, @ReferralID, @Referral

WHILE @@FETCH_STATUS = 0
BEGIN
--      Get the Member in the same company with the referring reference and not the same  
	SET @RefID = 0 
	SELECT @RefID = ISNULL(MemberID,0) FROM Member 
	WHERE CompanyID = @CompanyID AND MemberID <> @ReferralID AND Reference = @Referral
	IF @RefID > 0 
	BEGIN
		UPDATE Member SET ReferralID = @RefID WHERE MemberID = @MemberID
		SET @Count = @Count + 1
	END
	FETCH NEXT FROM Member_cursor INTO @MemberID, @CompanyID, @ReferralID, @Referral
END
CLOSE Member_cursor
DEALLOCATE Member_cursor

GO