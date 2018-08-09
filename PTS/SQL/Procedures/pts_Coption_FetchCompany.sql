EXEC [dbo].pts_CheckProc 'pts_Coption_FetchCompany'
GO

CREATE PROCEDURE [dbo].pts_Coption_FetchCompany
   @CompanyID int ,
   @CoptionID int OUTPUT
AS

SET NOCOUNT ON

SELECT      @CoptionID = cop.CoptionID
FROM Coption AS cop (NOLOCK)
WHERE (cop.CompanyID = @CompanyID)


GO