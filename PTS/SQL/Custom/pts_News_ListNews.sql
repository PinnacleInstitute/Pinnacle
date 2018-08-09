EXEC [dbo].pts_CheckProc 'pts_News_ListNews'
GO

--EXEC pts_News_ListNews 12, 2, 0

CREATE PROCEDURE [dbo].pts_News_ListNews
   @CompanyID int,
   @Status int,
   @NewsTopicID int
AS
-- ***********************************
-- Status: 1 ... Strategic
-- Status: 2 ... Main Stories
-- Status: 3 ... Main Breaking
-- Status: 4 ... Topic Stories
-- Status: 5 ... Topic Breaking
-- Status: 6 ... Top Topics (top news for each topic)
-- ***********************************
SET NOCOUNT ON

DECLARE @Now datetime, @Seq int, @Seq2 int
SET @Now = GETDATE()

-- Strategic News Stories
IF @Status = 1
BEGIN
	SELECT TOP 12 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nwt.NewsTopicName AS 'NewsTopicName', 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.IsStrategic <> 0
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC
END

-- Main News Stories
IF @Status = 2
BEGIN
	DECLARE @News TABLE(
	   NewsID int,
	   UserName nvarchar (100),
	   NewsTopicName nvarchar (100),
	   Title nvarchar (150),
	   Description nvarchar (1000),
	   CreateDate datetime,
	   ActiveDate datetime,
	   Image nvarchar (80),
	   Tags nvarchar (80),
	   Status int,
	   Seq int,
	   LeadMain int,
	   LeadTopic int,
	   IsBreaking bit,
	   IsBreaking2 bit,
	   IsStrategic bit,
	   UserRole int
	)
	   
--	Main Primary Stories
	INSERT INTO @News
	SELECT TOP 10 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         nwt.NewsTopicName, 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.LeadMain = 1
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC

--	Main Secondary Stories
--	Include Breaking Storeis not in the top 11 already displayed on the main page 
	INSERT INTO @News
	SELECT TOP 10 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         nwt.NewsTopicName, 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, 2, nw.LeadTopic, 0, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.ActiveDate <= @Now
	AND ( nw.LeadMain = 2 OR ( nw.IsBreaking <> 0 AND nw.NewsID NOT IN (SELECT NewsID FROM @News) ) )
	AND nw.NewsID NOT IN (
		SELECT TOP 11 nw.NewsID
		FROM News AS nw (NOLOCK)
		LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
		LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
		WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
		AND nw.IsBreaking <> 0
		AND nw.ActiveDate <= @Now
		ORDER BY nw.ActiveDate DESC
	)
	ORDER BY nw.ActiveDate DESC

	SELECT NewsID,UserName,NewsTopicName,Title,Description,CreateDate,ActiveDate,Image,Tags,Status,Seq,LeadMain,LeadTopic,IsBreaking,IsBreaking2,IsStrategic,UserRole FROM @News

END

-- Main Breaking News Stories
IF @Status = 3
BEGIN
	SELECT TOP 11 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nwt.NewsTopicName AS 'NewsTopicName', 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.IsBreaking <> 0
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC
END

-- Topic News Stories
IF @Status = 4
BEGIN
	DECLARE @TNews TABLE(
	   NewsID int,
	   UserName nvarchar (100),
	   NewsTopicName nvarchar (100),
	   Title nvarchar (150),
	   Description nvarchar (1000),
	   CreateDate datetime,
	   ActiveDate datetime,
	   Image nvarchar (80),
	   Tags nvarchar (80),
	   Status int,
	   Seq int,
	   LeadMain int,
	   LeadTopic int,
	   IsBreaking bit,
	   IsBreaking2 bit,
	   IsStrategic bit,
	   UserRole int
	)
	
--	Topic Primary Stories
	INSERT INTO @TNews
	SELECT TOP 10 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         nwt.NewsTopicName, 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.NewsTopicID = @NewsTopicID
	AND nw.LeadTopic = 1
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC

--	Check if This is a main topic
	SELECT @Seq = Seq FROM NewsTopic WHERE NewsTopicID = @NewsTopicID
--	If this is a main topic get all subtopic stories
--	If this is a subtopic only get subtopic topic stories
	IF (@Seq % 100) = 0 SET @Seq2 = @Seq + 100 ELSE SET @Seq2 = @Seq
	  
--	Topic Secondary Stories
	INSERT INTO @TNews
	SELECT TOP 20 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)), 
         nwt.NewsTopicName, 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
--	AND nw.NewsTopicID = @NewsTopicID
	AND nwt.Seq >= @Seq AND nwt.Seq < @Seq2
	AND nw.LeadTopic = 2
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC

	SELECT NewsID,UserName,NewsTopicName,Title,Description,CreateDate,ActiveDate,Image,Tags,Status,Seq,LeadMain,LeadTopic,IsBreaking,IsBreaking2,IsStrategic,UserRole FROM @TNews

END

-- Topic Breaking News Stories
IF @Status = 5
BEGIN
	SELECT TOP 7 nw.NewsID, 
         LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) AS 'UserName', 
         nwt.NewsTopicName AS 'NewsTopicName', 
         nw.Title, nw.Description, nw.CreateDate, nw.ActiveDate, nw.Image, nw.Tags, nw.Status, 
         nw.Seq, nw.LeadMain, nw.LeadTopic, nw.IsBreaking, nw.IsBreaking2, nw.IsStrategic, nw.UserRole
	FROM News AS nw (NOLOCK)
	LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nw.AuthUserID = au.AuthUserID)
	LEFT OUTER JOIN NewsTopic AS nwt (NOLOCK) ON (nw.NewsTopicID = nwt.NewsTopicID)
	WHERE nw.CompanyID = @CompanyID	AND nw.Status = 4
	AND nw.NewsTopicID = @NewsTopicID
	AND nw.IsBreaking2 <> 0
	AND nw.ActiveDate <= @Now
	ORDER BY nw.ActiveDate DESC
END

-- Top Topics (top news for each topic)
IF @Status = 6
BEGIN
	DECLARE @BNews TABLE(
	   NewsID int,
	   Title nvarchar (150),
	   ActiveDate datetime,
	   Image nvarchar (80),
	   Status int,
	   LeadTopic int
	)
	 
	DECLARE News_Cursor CURSOR LOCAL STATIC FOR 

	SELECT NewsTopicID, Seq FROM NewsTopic (NOLOCK)
	WHERE CompanyID = @CompanyID AND IsActive <> 0 AND (Seq % 100) = 0
	ORDER BY Seq

	OPEN News_Cursor
	FETCH NEXT FROM News_Cursor INTO @NewsTopicID, @Seq

	WHILE @@FETCH_STATUS = 0
	BEGIN
		INSERT INTO @BNews
		SELECT TOP 4 nw.NewsID, nw.Title, nw.ActiveDate, nw.Image, @NewsTopicID, nw.LeadTopic
		FROM News AS nw (NOLOCK)
		JOIN NewsTopic AS nt ON nw.NewsTopicID = nt.NewsTopicID
		WHERE nw.CompanyID = @CompanyID AND Status = 4
		AND nt.Seq >= @Seq AND nt.Seq < (@Seq+100)
		AND nw.LeadTopic != 0
		AND nw.ActiveDate <= @Now
		ORDER BY nw.LeadTopic, nw.ActiveDate DESC

		FETCH NEXT FROM News_Cursor INTO @NewsTopicID, @Seq
	END
	CLOSE News_Cursor
	DEALLOCATE News_Cursor

	SELECT NewsID,'' AS 'UserName','' AS 'NewsTopicName',Title,'' AS 'Description',0 AS 'CreateDate',ActiveDate,Image,'' AS 'Tags',Status,0 AS 'Seq',0 AS 'LeadMain',LeadTopic,0 AS 'IsBreaking',0 AS 'IsBreaking2',0 AS 'IsStrategic',0 AS 'UserRole' FROM @BNews

END

GO

