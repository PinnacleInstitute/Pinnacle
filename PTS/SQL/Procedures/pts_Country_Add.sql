EXEC [dbo].pts_CheckProc 'pts_Country_Add'
 GO

CREATE PROCEDURE [dbo].pts_Country_Add ( 
   @CountryID int OUTPUT,
   @CountryName nvarchar (50),
   @Code varchar (2),
   @Curr int,
   @UserID int
      )
AS

DECLARE @mNow datetime
DECLARE @mNewID int

SET NOCOUNT ON

SET @mNow = GETDATE()


INSERT INTO Country (
            CountryName , 
            Code , 
            Curr
            )
VALUES (
            @CountryName ,
            @Code ,
            @Curr            )

SET @mNewID = @@IDENTITY

SET @CountryID = @mNewID

GO