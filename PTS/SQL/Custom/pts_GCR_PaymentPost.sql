EXEC [dbo].pts_CheckProc 'pts_GCR_PaymentPost'
GO
--select * from payment where paymentid = 21937
--select * from SalesOrder where salesorderid = 15631
--declare @Result varchar(1000) EXEC pts_GCR_PaymentPost 90549, @Result output print @Result
--SELECT OwnerType, OwnerID, Status FROM Payment WHERE PaymentID = 19698

--DECLARE @Result int EXEC pts_GCR_PaymentPost 122370, @Result OUTPUT PRINT @Result

CREATE PROCEDURE [dbo].pts_GCR_PaymentPost
   @PaymentID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @OwnerType int, @OwnerID int, @Status int, @CommStatus int, @Count int, @MemberID int, @SalesOrderID int, @Options2 varchar(40), @Result2 int, @Status2 int
DECLARE @Sponsor3ID int, @Now datetime, @Today datetime, @PayDate datetime, @Notes varchar(500), @ReferralID int, @Purpose nvarchar (100), @Title int, @newTitle int, @cnt int, @MemberStatus int
DECLARE @Advance int, @Test int, @PaidDate datetime

SET @Test = 1
SET @Now = GETDATE()
SET @Today = dbo.wtfn_DateOnly( @Now )
SET @Count = 0
SET @Advance = 0

SELECT @OwnerType = OwnerType, @OwnerID = OwnerID, @Status = [Status], @CommStatus = CommStatus, @PayDate = PayDate, @Notes = Notes, @Purpose = Purpose 
FROM Payment WHERE PaymentID = @PaymentID

-- Process Submitted, Pending, Approved and Declined Payments
IF @Status >= 1 AND @Status <= 4 
BEGIN
--	If the payment is Approved
	IF @Status = 3
	BEGIN
--		If Approved payment, check for a possible change to the bonus qualified status for this member
		SELECT @MemberStatus = Status, @Title = Title, @ReferralID = ReferralID FROM Member WHERE MemberID = @OwnerID
		IF @MemberStatus = 2
		BEGIN
			SET @Advance = 1
			EXEC pts_GCR_TrialActivate @PaymentID, @OwnerID 
		END

--		Adjust the member's next bill date
		SET @PaidDate = DATEADD( d, 31, @Today )
		UPDATE Member SET PaidDate = @PaidDate WHERE MemberID = @OwnerID

--		Check for promotion	from new order or monthly autoship
		IF CHARINDEX(@Purpose, '102,103,104,105,106,107,108,202,203,204,205,206,207,208') > 0
		BEGIN
			SET @newTitle = @Title
			If @Purpose IN ('102','202') AND @Title < 2 SET @newTitle = 2
			If @Purpose IN ('103','203') AND @Title < 3 SET @newTitle = 3
			If @Purpose IN ('104','204') AND @Title < 4 SET @newTitle = 4
			If @Purpose IN ('105','205') AND @Title < 5 SET @newTitle = 5
			If @Purpose IN ('106','206') AND @Title < 5 SET @newTitle = 5
			If @Purpose IN ('107','207') AND @Title < 5 SET @newTitle = 5
			If @Purpose IN ('108','208') AND @Title < 5 SET @newTitle = 5
			If @newTitle > @Title
			BEGIN
				UPDATE Member SET Title = @newTitle, MaxMembers = @newTitle WHERE MemberID = @OwnerID
				SET @Advance = 1
			END
		END
		
		EXEC pts_GCR_QualifiedMember @OwnerID, 1, 0, @Result2
		EXEC pts_GCR_Placement @OwnerID
--		IF @Advance <> 0 EXEC pts_Commission_CalcAdvancement_17 @ReferralID, 0, @cnt OUTPUT
		EXEC pts_Commission_CalcAdvancement_17 @ReferralID, 0, @cnt OUTPUT

--		If the payment is not bonused yet - calc bonuses
		IF @CommStatus = 1 EXEC pts_Commission_Company_17a @PaymentID, @Count OUTPUT
	END
	SET @Result = @Count
END

GO 
