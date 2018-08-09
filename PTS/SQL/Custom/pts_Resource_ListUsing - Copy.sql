EXEC [dbo].pts_CheckProc 'pts_Resource_ListUsing'
GO
--EXEC pts_Resource_ListUsing 6528

CREATE PROCEDURE [dbo].pts_Resource_ListUsing
   @MemberID int
AS

SET NOCOUNT ON
DECLARE @ResourceID int, @ResourceType int, @ShareID int, @cnt int
DECLARE @tmpResource TABLE(
	ResourceID int, 
	ResourceType int, 
	ShareID int, 
	ShareName nvarchar(62),
	IsExclude bit
)

INSERT INTO @tmpResource
SELECT rs.ResourceID, rs.ResourceType, rs.ShareID, me.CompanyName, 0
FROM Resource AS rs (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (rs.ShareID = me.MemberID)
WHERE rs.MemberID = @MemberID AND rs.Share = 0

DECLARE Resource_cursor CURSOR FOR 
SELECT ResourceID, ResourceType, ShareID FROM @tmpResource

OPEN Resource_cursor
FETCH NEXT FROM Resource_cursor INTO @ResourceID, @ResourceType, @ShareID
WHILE @@FETCH_STATUS = 0
BEGIN
	SELECT @cnt = COUNT(*) FROM Resource 
	WHERE MemberID = @ShareID AND Share = 1 AND ResourceType = @ResourceType AND IsExclude = 0
	AND ( ShareID = 0 OR ShareID = @MemberID )

	IF @cnt = 0 
	BEGIN
		UPDATE @tmpResource SET IsExclude = 1 WHERE ResourceID = @ResourceID
	END
	
	FETCH NEXT FROM Resource_cursor INTO @ResourceID, @ResourceType, @ShareID
END
CLOSE Resource_cursor
DEALLOCATE Resource_cursor

SELECT ResourceID, ResourceType, ShareID, ShareName, IsExclude 
FROM @tmpResource ORDER BY ResourceType, ShareName

GO

