EXEC [dbo].pts_CheckProc 'pts_EmailSource_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_Fetch ( 
   @EmailSourceID int,
   @EmailSourceName nvarchar (30) OUTPUT,
   @EmailSourceFrom varchar (500) OUTPUT,
   @EmailSourceFields varchar (4000) OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @EmailSourceName = ems.EmailSourceName ,
   @EmailSourceFrom = ems.EmailSourceFrom ,
   @EmailSourceFields = ems.EmailSourceFields
FROM EmailSource AS ems (NOLOCK)
WHERE ems.EmailSourceID = @EmailSourceID

GO