EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_95'
GO

--TEST
--EXEC pts_Emailee_ListCustom_95 5, '1', '12', '', '', ''

-- Member Enrollment Day
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_95
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Days int, @Now datetime, @Status int
IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = 0

IF @Data2 != '' 
	SET @Days = CAST(@Data2 AS int)
Else
	SET @Days = 1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1',
       dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data2', 
       re.Email AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
LEFT OUTER JOIN Member AS re ON me.ReferralID = re.MemberID
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(me.EnrollDate)) = @Now
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
