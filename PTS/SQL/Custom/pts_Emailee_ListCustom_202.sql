EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_202'
GO

--TEST
--EXEC pts_Emailee_ListCustom_202 5, '1', '', '', '', ''

-- CloudZow New Affiliates
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_202
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

IF @Days >= 0 
BEGIN
	SELECT me.MemberID AS 'EmaileeID', 
		   me.Email AS 'Email', 
		   me.NameFirst AS 'FirstName', 
		   me.NameLast AS 'LastName', 
		   dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data1', 
		   CAST(me.Process AS varchar(2)) AS 'Data2',
		   ISNULL(re.Email,'') AS 'Data3',
		   '' AS 'Data4',
		   '' AS 'Data5'
	FROM Member AS me (NOLOCK)
	LEFT OUTER JOIN Member AS re ON me.ReferralID = re.MemberID
	WHERE me.CompanyID = 5 AND me.Status = 1 AND me.Level = 1 AND me.Title > 1 AND me.GroupID <> 100
	AND DATEADD( day, @Days, dbo.wtfn_DateOnly(me.EnrollDate)) = @Now
	AND me.EnrollDate > '6/28/12'
	AND me.IsMsg != 2
	ORDER BY me.MemberID
END
IF @Days < 0 
BEGIN
	SELECT me.MemberID AS 'EmaileeID', 
		   me.Email AS 'Email', 
		   me.NameFirst AS 'FirstName', 
		   me.NameLast AS 'LastName', 
		   dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data1', 
		   CAST(me.Process AS varchar(2)) AS 'Data2',
		   ISNULL(re.Email,'') AS 'Data3',
		   '' AS 'Data4',
		   '' AS 'Data5'
	FROM Member AS me (NOLOCK)
	LEFT OUTER JOIN Member AS re ON me.ReferralID = re.MemberID
	WHERE me.CompanyID = 5 AND me.Status = 1 AND me.Level = 1 AND me.Title > 1 AND me.GroupID <> 100
--	AND DATEADD( day, @Days, dbo.wtfn_DateOnly(me.EnrollDate)) = @Now
	AND me.EnrollDate < '6/28/12'
	AND me.IsMsg != 2
	ORDER BY me.MemberID
END

GO
