EXEC [dbo].pts_CheckProc 'pts_Country_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Country_Delete ( 
   @CountryID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE cou
FROM Country AS cou
WHERE cou.CountryID = @CountryID

GO