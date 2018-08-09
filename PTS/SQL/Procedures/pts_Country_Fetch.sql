EXEC [dbo].pts_CheckProc 'pts_Country_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Country_Fetch ( 
   @CountryID int,
   @CountryName nvarchar (50) OUTPUT,
   @Code varchar (2) OUTPUT,
   @Curr int OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CountryName = cou.CountryName ,
   @Code = cou.Code ,
   @Curr = cou.Curr
FROM Country AS cou (NOLOCK)
WHERE cou.CountryID = @CountryID

GO