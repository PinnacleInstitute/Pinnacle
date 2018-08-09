EXEC [dbo].pts_CheckProc 'pts_EmailSource_List'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_List ( 
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT         ems.EmailSourceID 'EmailSourceID' ,
            ems.EmailSourceName 'EmailSourceName' ,
            ems.EmailSourceFrom 'EmailSourceFrom' ,
            ems.EmailSourceFields 'EmailSourceFields'
FROM EmailSource AS ems (NOLOCK)
ORDER BY  'EmailSourceName'

GO