EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_203'
GO

--TEST
--EXEC pts_Emailee_ListCustom_203 5, '1', '', '', '', ''

-- CloudZow Prospects on Sales Campaign #5 - "Recruiting Emails"
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_203
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Days int, @Now datetime

IF @Data1 != '' 
	SET @Days = CAST(@Data1 AS int)
Else
	SET @Days = 1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT pr.ProspectID AS 'EmaileeID', 
       pr.Email AS 'Email', 
       pr.NameFirst AS 'FirstName', 
       pr.NameLast AS 'LastName', 
       dbo.wtfn_DateOnlyStr(pr.CreateDate) AS 'Data1', 
       CAST(pr.Status AS varchar(5)) AS 'Data2',
       me.Email AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Prospect AS pr (NOLOCK)
LEFT OUTER JOIN Member AS me ON pr.MemberID = me.MemberID
WHERE me.CompanyID = 5 AND pr.SalesCampaignID = 5 AND (pr.Status < 3 OR pr.Status > 5)
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(pr.CreateDate)) = @Now

GO
