EXEC [dbo].pts_CheckProc 'pts_Country_List'
GO

CREATE PROCEDURE [dbo].pts_Country_List
   @UserID int
AS

SET NOCOUNT ON

SELECT      cou.CountryID, 
         cou.CountryName, 
         cou.Code, 
         cou.Curr
FROM Country AS cou (NOLOCK)
ORDER BY   cou.CountryName

GO