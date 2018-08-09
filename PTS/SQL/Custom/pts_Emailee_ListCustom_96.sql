EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_96'
GO

--TEST
--EXEC pts_Emailee_ListCustom_96 13, '', '', '', '', ''

-- Trial Memberships
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_96
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
	SET @Days = CAST(@Data1 AS int) * -1
Else
	SET @Days = -1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       dbo.wtfn_DateOnlyStr(DATEADD(day,me.TrialDays,me.EnrollDate)) AS 'Data1', 
       dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data2', 
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND me.Status = 2
AND DATEADD( day, @Days, DATEADD(day, me.TrialDays, me.EnrollDate) ) = @Now
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
