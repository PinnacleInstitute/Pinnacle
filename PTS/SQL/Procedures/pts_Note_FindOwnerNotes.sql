EXEC [dbo].pts_CheckProc 'pts_Note_FindOwnerNotes'
 GO

CREATE PROCEDURE [dbo].pts_Note_FindOwnerNotes ( 
   @SearchText varchar (1000),
   @Bookmark varchar (1010),
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

SELECT TOP 21
            ISNULL(nt.Notes, '') + dbo.wtfn_FormatNumber(nt.NoteID, 10) 'BookMark' ,
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
WHERE ISNULL(nt.Notes, '') LIKE '%' + @SearchText + '%'
AND ISNULL(nt.Notes, '') + dbo.wtfn_FormatNumber(nt.NoteID, 10) >= @BookMark
AND         (nt.OwnerType = @OwnerType)
AND         (nt.OwnerID = @OwnerID)
AND         (nt.NoteDate >= @FromDate)
AND         (nt.NoteDate <= @ToDate)
ORDER BY 'Bookmark'

GO