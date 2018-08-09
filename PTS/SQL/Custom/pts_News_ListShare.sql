EXEC [dbo].pts_CheckProc 'pts_News_ListShare'
GO

--EXEC pts_News_ListShare 12, 0, '11/13/13', '11/14/13' 
--EXEC pts_News_ListShare 12, 1, 0, 0 

CREATE PROCEDURE [dbo].pts_News_ListShare
   @CompanyID int ,
   @Status int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

If @Status = 1
BEGIN
	SET @ToDate = GETDATE()
	
	SELECT TOP 12 nw.NewsID, 
			 nwt.NewsTopicName AS 'NewsTopicName', 
			 nw.Title, 
			 nw.Description, 
			 nw.ActiveDate, 
			 nw.Image 
	FROM News AS nw
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID AND nw.IsShare <> 0
	 AND ActiveDate <= @ToDate 
	ORDER BY ActiveDate DESC
END
ELSE
BEGIN
	SELECT   nw.NewsID, 
			 nwt.NewsTopicName AS 'NewsTopicName', 
			 nw.Title, 
			 nw.Description, 
			 nw.ActiveDate, 
			 nw.Image 
	FROM News AS nw
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID AND nw.IsShare <> 0
	 AND ActiveDate >= @FromDate AND ActiveDate <= @ToDate 
	ORDER BY ActiveDate DESC
END

GO