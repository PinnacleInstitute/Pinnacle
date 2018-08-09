EXEC [dbo].pts_CheckProc 'pts_EmailSource_Update'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_Update ( 
   @EmailSourceID int,
   @EmailSourceName nvarchar (30),
   @EmailSourceFrom varchar (500),
   @EmailSourceFields varchar (4000),
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE ems
SET ems.EmailSourceName = @EmailSourceName ,
   ems.EmailSourceFrom = @EmailSourceFrom ,
   ems.EmailSourceFields = @EmailSourceFields
FROM EmailSource AS ems
WHERE ems.EmailSourceID = @EmailSourceID

GO