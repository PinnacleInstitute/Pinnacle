EXEC [dbo].pts_CheckProc 'pts_Forum_ListFavorite'
GO

CREATE PROCEDURE [dbo].pts_Forum_ListFavorite
   @BoardUserID int ,
   @MessageDate datetime ,
   @Seq int
AS

SET NOCOUNT ON

DECLARE @AuthUserID int, @MemberID int
SET @MemberID = @BoardUserID
SELECT @AuthUserID = AuthUserID FROM Member WHERE MemberID = @MemberID

-- Get All Favorite Conference Rooms
IF @Seq = 30
BEGIN
	SELECT fo.ForumID, 
	       fo.ForumName, 
	       0 AS 'Seq'
	FROM   Forum AS fo
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 3)
	WHERE  fa.MemberID = @MemberID
END

-- Get All Favorite Discussion Boards
IF @Seq = 31
BEGIN
	SELECT fo.ForumID, 
	       fo.ForumName, 
	       COUNT(msg.MessageID) AS 'Seq'
	FROM   Message AS msg
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID
	GROUP BY fo.ForumID, fo.ForumName     
END

-- Get new Posted Messages
IF @Seq = 36 OR @Seq = 37
BEGIN
	SELECT fo.ForumID, 
	       fo.ForumName, 
	       COUNT(msg.MessageID) AS 'Seq'
	FROM   Message AS msg
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @MessageDate    
	GROUP BY fo.ForumID, fo.ForumName     
END

-- Get new Replied Messages
IF @Seq = 38 OR @Seq = 39
BEGIN
	SELECT fo.ForumID, 
		   fo.ForumName, 
		   COUNT(msg.MessageID) AS 'Seq'
	FROM   Message AS msg
	JOIN   Message AS rmsg ON (rmsg.MessageID = msg.ParentID)
	JOIN   BoardUser AS bu ON (bu.BoardUserID = msg.BoardUserID)
	JOIN   Forum AS fo ON msg.ForumID = fo.ForumID
	JOIN   Favorite AS fa ON (fa.RefID = fo.ForumID AND fa.RefType = 4)
	WHERE  bu.AuthUserID = @AuthUserID AND msg.CreateDate > @MessageDate
	GROUP BY fo.ForumID, fo.ForumName    
END

GO