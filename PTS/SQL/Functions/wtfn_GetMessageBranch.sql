IF EXISTS (SELECT * FROM dbo.sysobjects WHERE id = object_id(N'[dbo].[wtfn_GetMessageBranch]') AND type IN (N'FN', N'IF', N'TF'))
DROP FUNCTION [dbo].[wtfn_GetMessageBranch]
GO

CREATE FUNCTION dbo.wtfn_GetMessageBranch(@MessageID int)
RETURNS @MessageBranch TABLE (MessageID int, ParentID int)
AS  
BEGIN 
	INSERT INTO @MessageBranch
	SELECT MessageID, ParentID FROM Message WHERE MessageID=@MessageID

	DECLARE @LoopID int, @ParentID int

	DECLARE MessageCursor CURSOR STATIC LOCAL FOR
	SELECT MessageID, ParentID FROM Message WHERE ParentID=@MessageID

	OPEN MessageCursor

	FETCH NEXT FROM MessageCursor
	INTO @LoopID, @ParentID

	WHILE (@@FETCH_STATUS = 0) 
	BEGIN
		INSERT INTO @MessageBranch
		SELECT * FROM dbo.wtfn_GetMessageBranch(@LoopID)
  
		INSERT INTO @MessageBranch
		VALUES(@LoopID, @ParentID)
   
		FETCH NEXT FROM MessageCursor
		INTO @LoopID, @ParentID
	END
	
	CLOSE MessageCursor
	DEALLOCATE MessageCursor

	RETURN
END
