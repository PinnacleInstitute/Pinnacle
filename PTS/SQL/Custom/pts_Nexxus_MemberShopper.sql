EXEC [dbo].pts_CheckProc 'pts_Nexxus_MemberShopper'
GO

--EXEC pts_Nexxus_MemberShopper 37703
-- select top 1 * from consumer order by consumerid desc

CREATE PROCEDURE [dbo].pts_Nexxus_MemberShopper
   @MemberID int 
AS

SET NOCOUNT ON

DECLARE @SponsorID int, @Email nvarchar(80), @ID int, @Now datetime, @ConsumerID int
SET @Now = GETDATE()
SET @SponsorID = 1

SELECT @Email = Email, @SponsorID = SponsorID FROM Member where MemberID = @MemberID

IF @SponsorID = 0
BEGIN
	SET @ID = 0
	SELECT @ID = ConsumerID FROM Consumer WHERE Email = @Email	

	IF @ID > 0
	BEGIN
		UPDATE Member SET SponsorID = @ID WHERE MemberID = @MemberID	
	END
	ELSE
	BEGIN
		DECLARE @AuthUserID int, @CountryID int, @NameLast nvarchar(30), @NameFirst nvarchar(30), @Phone nvarchar(20), @Password nvarchar(20)
		DECLARE @Street1 nvarchar(60), @Street2 nvarchar(60), @City nvarchar(30), @State nvarchar(30), @Zip nvarchar(20)
		DECLARE @Result nvarchar(1000)

		SELECT @AuthUserID = AuthUserID, @NameLast = NameLast, @NameFirst = NameFirst, @Phone = Phone1 FROM Member WHERE MemberID = @MemberID

		-- Strip non-digits from phone number
		SET @Phone = dbo.wtfn_DigitsOnly(@Phone)

		SELECT @Password = Password FROM AuthUser WHERE AuthUserID = @AuthUserID

		SELECT TOP 1 @Street1 = Street1, @Street2 = Street2, @City = City, @State = State, @Zip = Zip, @CountryID = CountryID FROM Address WHERE OwnerType = 4 AND OwnerID = @MemberID

		--ConsumerID,MemberID,MerchantID,ReferID,CountryID,CountryID2,AffiliateID,NameLast,NameFirst,Email,Email2,Phone,Provider,Password,Status,Messages,
		--Street1,Street2,City,State,Zip,City2,State2,Zip2,Referrals,Cash,Points,VisitDate,EnrollDate,UserKey,Barter,UserID
		EXEC pts_Consumer_Add @ConsumerID OUTPUT, @MemberID, 0, 0, @CountryID, @CountryID, @MemberID, @NameLast, @NameFirst, @Email, @Email, @Phone, 0, @Password, 2, 1,
		   @Street1, @Street2, @City, @State, @Zip, '', '', '', 0, 0, 0, 0, @Now, '', '', 1

		IF @ConsumerID > 0
		BEGIN
			-- Initialize New Shopper
			EXEC pts_Consumer_Custom @ConsumerID, 99, 0, 0, '', @Result
			
			-- Assign ShopperID to Affiliate
			UPDATE Member SET SponsorID = @ConsumerID WHERE MemberID = @MemberID	
		END
	END
END

GO

