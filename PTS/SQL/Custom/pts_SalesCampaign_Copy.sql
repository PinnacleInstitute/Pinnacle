EXEC [dbo].pts_CheckProc 'pts_SalesCampaign_Copy'
GO

CREATE PROCEDURE [dbo].pts_SalesCampaign_Copy
   @SalesCampaignID int ,
   @CompanyID int
AS

DECLARE @CopySalesCampaignID int
SET @CopySalesCampaignID = @CompanyID

DECLARE @SalesStepID int, @SalesStepName nvarchar (40), @Description nvarchar (100), 
	@EmailID int, @Seq int, @AutoStep int, @NextStep int, @Delay int, @DateNo int, @IsBoard bit, @BoardRate money, @Length int, @Email nvarchar (100) 

-- COPY ALL SALES STEPS
	DECLARE Step_cursor CURSOR LOCAL STATIC FOR 
	SELECT SalesStepName, EmailID, Description, Seq, AutoStep, NextStep, Delay, DateNo, IsBoard, BoardRate, Length, Email  
	FROM SalesStep WHERE SalesCampaignID = @CopySalesCampaignID
	OPEN Step_cursor
	FETCH NEXT FROM Step_cursor INTO @SalesStepName, @EmailID, @Description, @Seq, @AutoStep, 
					@NextStep, @Delay, @DateNo, @IsBoard, @BoardRate, @Length, @Email  
	WHILE @@FETCH_STATUS = 0
	BEGIN
--		SalesStepID,SalesCampaignID,EmailID,SalesStepName,Description,
--		Seq,AutoStep,NextStep,Delay,DateNo,IsBoard,BoardRate,Length,Email,UserID
		EXEC pts_SalesStep_Add @SalesStepID OUTPUT, @SalesCampaignID, 0, @SalesStepName, @Description,
				     @Seq, @AutoStep, @NextStep, @Delay, @DateNo, @IsBoard, @BoardRate, 0, @Email, 1

		FETCH NEXT FROM Step_cursor INTO @SalesStepName, @EmailID, @Description, @Seq, @AutoStep, 
						@NextStep, @Delay, @DateNo, @IsBoard, @BoardRate, @Length, @Email  
	END
	CLOSE Step_cursor
	DEALLOCATE Step_cursor


GO
