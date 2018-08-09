EXEC [dbo].pts_CheckProc 'pts_LeadCampaign_ListAffiliateText'
GO

CREATE PROCEDURE [dbo].pts_LeadCampaign_ListAffiliateText
   @CompanyID int ,
   @Description nvarchar (500)
AS

SET NOCOUNT ON

DECLARE @IDs varchar (50), @ID1 int, @ID2 int, @ID3 int, @ID4 int, @ID5 int 
DECLARE @ID6 int, @ID7 int, @ID8 int, @ID9 int, @ID10 int 
DECLARE @x int, @cnt int, @ID int, @xspace int

SET @IDs = @Description
SET @ID1 = 0
SET @ID2 = 0
SET @ID3 = 0
SET @ID4 = 0
SET @ID5 = 0
SET @ID6 = 0
SET @ID7 = 0
SET @ID8 = 0
SET @ID9 = 0
SET @ID10 = 0

SET @cnt = 0
WHILE @IDs != ''
BEGIN
	SET @x = CHARINDEX(',', @IDs)
	SET @xspace = CHARINDEX(' ', @IDs)
--	Found comma and space, use the first one found	
	IF @x > 0 AND @xspace > 0 IF @xspace < @x SET @x = @xspace
--	Found space only, use the space
	IF @x = 0 AND @xspace > 0 SET @x = @xspace
--	Found comma only, use the comma

	IF @x > 0
	BEGIN
		SET @ID = CAST(SUBSTRING(@IDs, 1, @x-1) AS int)
		SET @IDs = LTRIM(SUBSTRING(@IDs, @x+1, LEN(@IDs)-@x))
	END
	ELSE
	BEGIN
		SET @ID = CAST(@IDs AS int)
		SET @IDs = ''
	END
	IF @ID!=@ID1 AND @ID!=@ID2 AND @ID!=@ID3 AND @ID!=@ID4 AND @ID!=@ID5 AND
	   @ID!=@ID6 AND @ID!=@ID7 AND @ID!=@ID8 AND @ID!=@ID9 AND @ID!=@ID10
	BEGIN
		SET @cnt = @cnt + 1
		IF @cnt = 1 SET @ID1 = @ID
		IF @cnt = 2 SET @ID2 = @ID
		IF @cnt = 3 SET @ID3 = @ID
		IF @cnt = 4 SET @ID4 = @ID
		IF @cnt = 5 SET @ID5 = @ID
		IF @cnt = 6 SET @ID6 = @ID
		IF @cnt = 7 SET @ID7 = @ID
		IF @cnt = 8 SET @ID8 = @ID
		IF @cnt = 9 SET @ID9 = @ID
		IF @cnt = 10 SET @ID10 = @ID
	END 
END 

SELECT  LeadCampaignID, 
	LeadCampaignName,  
	PageType, 
	Objective,
	CASE  
	WHEN LeadCampaignID = @ID1 THEN 1
	WHEN LeadCampaignID = @ID2 THEN 2
	WHEN LeadCampaignID = @ID3 THEN 3
	WHEN LeadCampaignID = @ID4 THEN 4
	WHEN LeadCampaignID = @ID5 THEN 5
	WHEN LeadCampaignID = @ID6 THEN 6
	WHEN LeadCampaignID = @ID7 THEN 7
	WHEN LeadCampaignID = @ID8 THEN 8
	WHEN LeadCampaignID = @ID9 THEN 9
	WHEN LeadCampaignID = @ID10 THEN 10
	END AS 'CycleID'
FROM LeadCampaign (NOLOCK)
WHERE CompanyID = @CompanyID
 AND Status = 2
 AND IsAffiliate <> 0
 AND PageType = 1
 AND LeadCampaignID IN (@ID1, @ID2, @ID3, @ID4, @ID5, @ID6, @ID7, @ID8, @ID9, @ID10)
ORDER BY CycleID

GO