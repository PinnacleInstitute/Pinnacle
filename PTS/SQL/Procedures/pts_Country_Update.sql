EXEC [dbo].pts_CheckProc 'pts_Country_Update'
 GO

CREATE PROCEDURE [dbo].pts_Country_Update ( 
   @CountryID int,
   @CountryName nvarchar (50),
   @Code varchar (2),
   @Curr int,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE cou
SET cou.CountryName = @CountryName ,
   cou.Code = @Code ,
   cou.Curr = @Curr
FROM Country AS cou
WHERE cou.CountryID = @CountryID

GO