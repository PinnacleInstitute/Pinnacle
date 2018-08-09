EXEC [dbo].pts_CheckProc 'pts_Message_FindBody'
 GO

CREATE PROCEDURE [dbo].pts_Message_FindBody ( 
   @SearchText nvarchar (2000),
   @Bookmark nvarchar (2010),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(mbm.Body, '') + dbo.wtfn_FormatNumber(mbm.MessageID, 10) 'BookMark' ,
            mbm.MessageID 'MessageID' ,
            mbm.ForumID 'ForumID' ,
            mbm.ParentID 'ParentID' ,
            mbm.ThreadID 'ThreadID' ,
            mbm.BoardUserID 'BoardUserID' ,
            mbm.ModifyID 'ModifyID' ,
            mbf.ForumName 'ForumName' ,
            mbu.BoardUserName 'BoardUserName' ,
            mbu.Signature 'Signature' ,
            mod.BoardUserName 'ModifyName' ,
            mbm.MessageTitle 'MessageTitle' ,
            mbm.Status 'Status' ,
            mbm.IsSticky 'IsSticky' ,
            mbm.Body 'Body' ,
            mbm.CreateDate 'CreateDate' ,
            mbm.ChangeDate 'ChangeDate' ,
            mbm.ThreadOrder 'ThreadOrder' ,
            mbm.Replies 'Replies'
FROM Message AS mbm (NOLOCK)
LEFT OUTER JOIN Forum AS mbf (NOLOCK) ON (mbm.ForumID = mbf.ForumID)
LEFT OUTER JOIN BoardUser AS mbu (NOLOCK) ON (mbm.BoardUserID = mbu.BoardUserID)
LEFT OUTER JOIN BoardUser AS mod (NOLOCK) ON (mbm.ModifyID = mod.BoardUserID)
WHERE ISNULL(mbm.Body, '') LIKE @SearchText + '%'
AND ISNULL(mbm.Body, '') + dbo.wtfn_FormatNumber(mbm.MessageID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO