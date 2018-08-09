EXEC [dbo].pts_CheckProc 'pts_Member_Custom'
GO
--DECLARE @Result varchar(1000) EXEC pts_Member_Custom 17, 12051, 1010, @Result output print @Result
--7944,7932
CREATE PROCEDURE [dbo].pts_Member_Custom
   @CompanyID int ,
   @MemberID int ,
   @Status int ,
   @Result varchar(1000) OUTPUT
AS

SET NOCOUNT ON
DECLARE @cnt int

IF @Status < 1000
BEGIN
	IF @CompanyID = 1 EXEC pts_Member_Custom_1 @MemberID, @Status, @Result OUTPUT
	IF @CompanyID = 5 EXEC pts_Member_Custom_5 @MemberID, @Status, @Result OUTPUT
	IF @CompanyID = 7 EXEC pts_Member_Custom_7 @MemberID, @Status, @Result OUTPUT
END
ELSE
BEGIN
--	*******************************************************************
--	Get Binary Sales Volume for both legs
--	*******************************************************************
	IF @Status = 1000
	BEGIN
		DECLARE @QVLeft money, @QVRight money, @BVLeft money, @BVRight money
		SET @QVLeft = 0
		SET @QVRight = 0
		SET @BVLeft = -1
		SET @BVRight = -1
		SELECT @QVLeft = QV4, @BVLeft = BV4 FROM Member WHERE Sponsor3ID = @MemberID AND Pos = 0 -- AND Status >= 1 And Status <= 4	
		SELECT @QVRight = QV4, @BVRight = BV4 FROM Member WHERE Sponsor3ID = @MemberID AND Pos = 1 -- AND Status >= 1 And Status <= 4	
		SET @Result = CAST(@QVLeft AS VARCHAR(20)) + ',' + CAST(@QVRight AS VARCHAR(20)) + ',' + CAST(@BVLeft+1 AS VARCHAR(20)) + ',' + CAST(@BVRight+1 AS VARCHAR(20))
	END
--	*******************************************************************
--	Get Bottom of Left Binary Leg
--	*******************************************************************
	IF @Status = 1001 OR @Status = 1002
	BEGIN
		DECLARE @ID int, @Pos int
		IF @Status = 1001 SET @Pos = 0
		IF @Status = 1002 SET @Pos = 1
		WHILE @MemberID	> 0
		BEGIN
			SET @ID = 0
			SELECT TOP 1 @ID = MemberID FROM Member WHERE Sponsor3ID = @MemberID AND Pos = @Pos AND Status > 0 -- AND Status >= 1 AND Status <= 4
			IF @ID = 0 SET @Result = CAST(@MemberID AS VARCHAR(20))
			SET @MemberID = @ID
			--print @MemberID
		END
	END
--	*******************************************************************
--	Get Payment (Inventory) Credits
--	*******************************************************************
	IF @Status = 1003
	BEGIN
		DECLARE @Amount money
		SET @Amount = 0
		SELECT @Amount = Amount FROM Payment WHERE OwnerType = 4 AND OwnerID = @MemberID AND PayType = 91
		SET @Result = CAST(@Amount AS VARCHAR(20))
	END
--	*******************************************************************
--	Get Member Country
--	*******************************************************************
	IF @Status = 1010
	BEGIN
		DECLARE @CountryID int
		SET @CountryID = 0
		SELECT TOP 1 @CountryID = ISNULL(CountryID,0) FROM Address WHERE OwnerType = 4 AND OwnerID = @MemberID AND IsActive <> 0
		IF @CountryID = 0 SELECT TOP 1 @CountryID = ISNULL(CountryID,0) FROM Address WHERE OwnerType = 4 AND OwnerID = @MemberID
		SET @Result = CAST(@CountryID AS VARCHAR(10))
	END
--	*******************************************************************
--	Add a Member as a contact for another member (admin use) 
--	*******************************************************************
	IF @Status = 1011
	BEGIN
		DECLARE @OrgMemberID int, @NewMemberID int
		DECLARE @NameLast nvarchar(30), @NameFirst nvarchar(30), @Email nvarchar(80), @Phone1 nvarchar(30), @Now datetime
		SET @OrgMemberID = @CompanyID
		SET @Now = GETDATE()
		SELECT @Result = ISNULL([Source],'') FROM Prospect WHERE MemberID = @OrgMemberID AND [Source] = CAST(@MemberID AS VARCHAR(10))
		IF @Result = ''
		BEGIN
			SELECT @CompanyID = CompanyID FROM Member WHERE MemberID = @OrgMemberID
			SELECT 	@NameLast=NameLast, @NameFirst=NameFirst, @Email=Email, @Phone1=Phone1 FROM Member WHERE MemberID = @MemberID	
			INSERT INTO Prospect ( CompanyID, MemberID, Status, EmailStatus, ProspectName, NameLast, NameFirst, Email, Phone1, [Source], CreateDate )
			VALUES ( @CompanyID, @OrgMemberID, -1, 2, @NameFirst + ' ' + @NameLast, @NameLast, @NameFirst, @Email, @Phone1, CAST(@MemberID AS VARCHAR(10)), @Now )
			SET @Result = CAST(@@IDENTITY AS VARCHAR(10))
		END
	END
	
--	*******************************************************************
--	Clear Lost Bonuses
--	*******************************************************************
	IF @Status = 1080
	BEGIN
		SELECT @cnt = COUNT(*) FROM Member WHERE CompanyID = @CompanyID AND Retail > 0
		SET @Result = CAST(@cnt AS VARCHAR(10))
		UPDATE Member SET Retail = 0 WHERE CompanyID = @CompanyID AND Retail > 0
		UPDATE Company SET LostBonusDate = GETDATE() WHERE CompanyID = @CompanyID
	END	

END

GO