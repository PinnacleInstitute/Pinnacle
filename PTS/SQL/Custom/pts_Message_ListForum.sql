EXEC [dbo].pts_CheckProc 'pts_Message_ListForum'
GO


CREATE PROCEDURE [dbo].pts_Message_ListForum
   @ForumID int ,
   @Page int ,
   @First datetime ,
   @UserID int
AS

DECLARE @Counter int

SET         NOCOUNT ON


--if first is passed as zero (1/1/1900) then the user is
--jumping to a new page, so calculate the first record
--of that page
IF @First = '1/1/1900' 
BEGIN
	SET @First = CURRENT_TIMESTAMP
	IF @Page > 0
	BEGIN
		

		SET @Counter = 0
		WHILE @Counter < @Page
		BEGIN
			SELECT @First = MIN(ChangeDate)
			FROM Message
			WHERE MessageID IN (
				SELECT TOP 20 MessageID 
				FROM Message
				WHERE (ParentID = 0)
					AND	(ForumID = @ForumID)
					AND	(IsSticky = 0)
					AND	(ChangeDate < @First)	
				ORDER BY   IsSticky DESC, ChangeDate DESC
			)			
			SET @Counter = @Counter + 1
		END
	END
END


SELECT mbm.MessageID,
         mbm.BoardUserID, 
         mbm.Status,
         mbm.IsSticky,
         mbu.BoardUserName AS 'BoardUserName', 
	 mbm.ModifyID,
         mod.BoardUserName AS 'ModifyName',
         mbm.MessageTitle, 
         mbm.CreateDate, 
         mbm.ChangeDate,
         mbm.Replies
FROM      Message AS mbm (NOLOCK)
         LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
         LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
WHERE      mbm.MessageID IN (	
	SELECT MessageID
	FROM      Message (NOLOCK)
	WHERE      (ParentID = 0)
		AND	(ForumID = @ForumID)
		AND	(IsSticky = 1)
	UNION ALL
	SELECT MessageID
	FROM	Message (NOLOCK)
	WHERE MessageID IN (
		SELECT TOP 20 MessageID
		FROM      Message (NOLOCK)
		WHERE      (ParentID = 0)
			AND	(ForumID = @ForumID)
			AND	(IsSticky = 0)
			AND	(ChangeDate < @First)	
		ORDER BY   ChangeDate DESC
	)
)
ORDER BY   mbm.IsSticky DESC, mbm.ChangeDate DESC

GO