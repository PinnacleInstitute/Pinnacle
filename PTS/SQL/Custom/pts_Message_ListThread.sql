EXEC [dbo].pts_CheckProc 'pts_Message_ListThread'
GO


CREATE PROCEDURE [dbo].pts_Message_ListThread
   @ThreadID int ,
   @Page int ,
   @PageSize int ,
   @Status int ,
   @UserID int
AS

DECLARE @First int,
	@Last int


SET         NOCOUNT ON

IF @Status = 1 
BEGIN
	SET @First = (@PageSize * @Page)
    SET @Last = @First + @PageSize - 1
	SELECT mbm.MessageID,
	         mbm.BoardUserID, 
                 mbm.ParentID,
                 mbm.ThreadOrder,
                 mbm.Status,
                 mbm.IsSticky,
	         mbu.BoardUserName AS 'BoardUserName', 
		 mbm.ModifyID,
                 mod.BoardUserName AS 'ModifyName',
	         mbm.MessageTitle, 
                 mbm.Body,
                 mbu.Signature AS 'Signature',
	         mbm.CreateDate, 
	         mbm.ChangeDate
	FROM      Message AS mbm (NOLOCK)
	         LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
	         LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
	WHERE      (mbm.ThreadID = @ThreadID)
		AND	(mbm.ThreadOrder BETWEEN @First AND @Last)	
	ORDER BY   mbm.ThreadOrder ASC
END
IF @Status = 2 
BEGIN
    SET @Last = (SELECT COUNT(*) FROM Message WHERE ThreadID = @ThreadID) - (@PageSize * @Page)
    SET @First = @Last - @PageSize + 1
    
	SELECT mbm.MessageID,
	         mbm.BoardUserID,
                 mbm.ParentID,
                 mbm.ThreadOrder,
                 mbm.Status,
                 mbm.IsSticky, 
	         mbu.BoardUserName AS 'BoardUserName', 
                 mbm.ModifyID,
                 mod.BoardUserName AS 'ModifyName',
	         mbm.MessageTitle, 
                 mbm.Body,
                 mbu.Signature AS 'Signature',
	         mbm.CreateDate, 
	         mbm.ChangeDate
	FROM      Message AS mbm (NOLOCK)
	         LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
	         LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
	WHERE      (mbm.ThreadID = @ThreadID)
		AND	(mbm.ThreadOrder BETWEEN @First AND @Last)	
	ORDER BY   mbm.ThreadOrder DESC
END


GO