EXEC [dbo].pts_CheckProc 'pts_Forum_UpdateMUC'
GO

CREATE PROCEDURE [dbo].pts_Forum_UpdateMUC
   @ForumID int,
   @ForumName nvarchar(60) ,
   @Description nvarchar(500)

AS

SET         NOCOUNT ON

DECLARE @Now varchar(15), @RoomID int

--get the current date in 0 padded, right aligned millisecond format
SET @Now = RIGHT('000000000000000' + CONVERT(VARCHAR(15), 
		CONVERT(BIGINT, 
			DATEDIFF(second, '19700101', CURRENT_TIMESTAMP)
		) * 1000 + DATEDIFF(millisecond,
			DATEADD(second,
				DATEDIFF(second, '19700101', CURRENT_TIMESTAMP),
				'19700101'),
			CURRENT_TIMESTAMP)
		), 15) 

UPDATE mucRoom 
SET 
	modificationDate = @Now, 
	name = @ForumName + ' ' + LTRIM(RTRIM(CAST(@ForumID AS nvarchar(10)))), 
	naturalName = @ForumName, 
	description = @Description
WHERE ForumID = @ForumID

GO