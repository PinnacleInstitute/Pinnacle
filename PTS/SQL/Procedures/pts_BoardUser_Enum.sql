EXEC [dbo].pts_CheckProc 'pts_BoardUser_Enum'
 GO

CREATE PROCEDURE [dbo].pts_BoardUser_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         mbu.BoardUserID 'ID' ,
            mbu.BoardUserName 'Name'
FROM BoardUser AS mbu (NOLOCK)
ORDER BY mbu.BoardUserName

GO