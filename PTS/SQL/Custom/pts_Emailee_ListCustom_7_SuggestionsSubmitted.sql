EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_7_SuggestionsSubmitted'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_7_SuggestionsSubmitted
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @CompanyID int, @Days int, @Now datetime
IF @Data1 != '' 
	SET @CompanyID = CAST(@Data1 AS int)
Else
	SET @CompanyID = 0

IF @Data2 != '' 
	SET @Days = CAST(@Data2 AS int)
Else
	SET @Days = 1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT su.SuggestionID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       su.Subject AS 'Data3', 
       fo.OrgName AS 'Data4',
       dbo.wtfn_DateOnlyStr(su.SuggestionDate) AS 'Data5'

FROM Suggestion AS su (NOLOCK)
JOIN Member AS me ON su.MemberID = me.MemberID
JOIN Company AS co ON me.CompanyID = co.CompanyID
JOIN Org AS fo ON su.OrgID = fo.OrgID

WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(su.SuggestionDate)) = @Now

GO
