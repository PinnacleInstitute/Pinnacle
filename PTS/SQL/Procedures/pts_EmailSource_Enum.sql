EXEC [dbo].pts_CheckProc 'pts_EmailSource_Enum'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_Enum ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         ems.EmailSourceID 'ID' ,
            ems.EmailSourceName 'Name'
FROM EmailSource AS ems (NOLOCK)
ORDER BY ems.EmailSourceName

GO