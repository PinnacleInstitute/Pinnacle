EXEC [dbo].pts_CheckProc 'pts_Note_FindOwnerNoteDate'
 GO

CREATE PROCEDURE [dbo].pts_Note_FindOwnerNoteDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @OwnerType int,
   @OwnerID int,
   @FromDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), nt.NoteDate, 112), '') + dbo.wtfn_FormatNumber(nt.NoteID, 10) 'BookMark' ,
            nt.NoteID 'NoteID' ,
            nt.OwnerType 'OwnerType' ,
            nt.OwnerID 'OwnerID' ,
            nt.AuthUserID 'AuthUserID' ,
            au.NameLast 'NameLast' ,
            au.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(au.NameFirst)) +  ' '  + LTRIM(RTRIM(au.NameLast)) 'UserName' ,
            nt.NoteDate 'NoteDate' ,
            nt.Notes 'Notes' ,
            nt.IsLocked 'IsLocked' ,
            nt.IsFrozen 'IsFrozen' ,
            nt.IsReminder 'IsReminder'
FROM Note AS nt (NOLOCK)
LEFT OUTER JOIN AuthUser AS au (NOLOCK) ON (nt.AuthUserID = au.AuthUserID)
WHERE ISNULL(CONVERT(nvarchar(10), nt.NoteDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), nt.NoteDate, 112), '') + dbo.wtfn_FormatNumber(nt.NoteID, 10) <= @BookMark
AND         (nt.OwnerType = @OwnerType)
AND         (nt.OwnerID = @OwnerID)
AND         (nt.NoteDate >= @FromDate)
AND         (nt.NoteDate <= @ToDate)
ORDER BY 'Bookmark' DESC

GO