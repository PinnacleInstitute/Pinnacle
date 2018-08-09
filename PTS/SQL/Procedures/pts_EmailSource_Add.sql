EXEC [dbo].pts_CheckProc 'pts_EmailSource_Add'
 GO

CREATE PROCEDURE [dbo].pts_EmailSource_Add ( 
   @EmailSourceID int OUTPUT,
   @EmailSourceName nvarchar (30),
   @EmailSourceFrom varchar (500),
   @EmailSourceFields varchar (4000),
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO EmailSource (
            EmailSourceName , 
            EmailSourceFrom , 
            EmailSourceFields
            )
VALUES (
            @EmailSourceName ,
            @EmailSourceFrom ,
            @EmailSourceFields            )

SET @mNewID = @@IDENTITY

SET @EmailSourceID = @mNewID

GO