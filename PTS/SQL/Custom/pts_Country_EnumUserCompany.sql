EXEC [dbo].pts_CheckProc 'pts_Country_EnumUserCompany'
GO

--EXEC pts_Country_EnumUserCompany 0, 1

CREATE PROCEDURE [dbo].pts_Country_EnumUserCompany
   @CompanyID int ,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @Countries nvarchar (100)

SET @Countries = ''
SELECT @Countries = RTRIM(Countries) FROM Coption WHERE CompanyID = @CompanyID

IF LEN(@Countries) = 0 
BEGIN
	SELECT   cou.CountryID AS 'ID', cou.CountryName AS 'Name'
	FROM     Country AS cou (NOLOCK)
	ORDER BY cou.CountryName
END
ELSE
BEGIN
	SELECT   cou.CountryID AS 'ID', cou.CountryName AS 'Name'
	FROM     Country AS cou (NOLOCK)
	WHERE    @Countries LIKE '%,' + CAST(cou.CountryID AS VARCHAR(3)) + ',%'
	ORDER BY cou.CountryName
END
GO