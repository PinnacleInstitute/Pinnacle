EXEC [dbo].pts_CheckProc 'pts_BarterCredit_Custom'
GO

--DECLARE @Result nvarchar (1000) EXEC pts_BarterCredit_Custom 1, 7, 2, '', @Result

CREATE PROCEDURE [dbo].pts_BarterCredit_Custom
   @Status int ,
   @BarterAdID int ,
   @CreditType int ,
   @Reference nvarchar (30) ,
   @Result nvarchar (1000) OUTPUT
AS

SET NOCOUNT ON

--Add Features to Barter Ad
IF @Status = 1
BEGIN
	DECLARE @ID int, @ConsumerID int, @Today datetime, @EndDate datetime, @AdEndDate datetime, @Code varchar(10), @Options varchar(20), @Amount money 
	SET @Today = dbo.wtfn_DateOnly(GETDATE())
	SET @EndDate = DATEADD(M,1,@Today)
	
	SELECT @ConsumerID = ConsumerID, @AdEndDate = EndDate, @Options = Options FROM BarterAd WHERE BarterAdID = @BarterAdID
	IF @AdEndDate < @EndDate SET @AdEndDate = @EndDate
	
	IF @CreditType = 2 BEGIN SET @Amount = -1 SET @Code = 'C' END -- Title
	IF @CreditType = 3 BEGIN SET @Amount = -3 SET @Code = 'd' END -- Images
	IF @CreditType = 4 -- Images+
	BEGIN
		SET @Amount = -5 
		-- if 10 images (d) is enabled, only charge the upgrade difference
		IF CHARINDEX('d', @Options) > 0 SET @Amount = -2
		SET @Code = 'D' 
	END
	IF @CreditType = 5 BEGIN SET @Amount = -3 SET @Code = 'E' END -- Editor
	IF @CreditType = 6 BEGIN SET @Amount = -5 SET @Code = 'F' END -- Long
	IF @CreditType = 7 BEGIN SET @Amount = -5 SET @Code = 'G' END -- Listing
	IF @CreditType = 8 BEGIN SET @Amount = -5 SET @Code = 'CdE' END -- Bundle 1
	IF @CreditType = 9 BEGIN SET @Amount = -10 SET @Code = 'CDEF' END  -- Bundle 2

	-- Create Barter Credit (Debit)
   -- BarterCreditID,OwnerType,OwnerID,BarterAdID,CreditDate,Amount,Status,CreditType,StartDate,EndDate,Reference,Notes,UserID
	EXEC pts_BarterCredit_Add @ID, 151, @ConsumerID, @BarterAdID, @Today, @Amount, 1, @CreditType, @Today, @EndDate, '', '', 1

	-- Update Barter Ad
	UPDATE BarterAd SET Options = Options + @Code, EndDate = @AdEndDate WHERE BarterAdID = @BarterAdID
END
GO

