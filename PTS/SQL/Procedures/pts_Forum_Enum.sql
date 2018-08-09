EXEC [dbo].pts_CheckProc 'pts_Forum_Enum'
 GO

CREATE PROCEDURE [dbo].pts_Forum_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         mbf.ForumID 'ID' ,
            mbf.ForumName 'Name'
FROM Forum AS mbf (NOLOCK)
ORDER BY mbf.ForumName

GO