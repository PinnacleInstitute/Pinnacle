EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_1_TrialMembership'
GO

CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_1_TrialMembership
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
	SET @Days = CAST(@Data2 AS int) * -1
Else
	SET @Days = -1

SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       co.CompanyID AS 'Data1', 
       co.CompanyName AS 'Data2', 
       dbo.wtfn_DateOnlyStr(DATEADD(day,me.TrialDays,me.EnrollDate)) AS 'Data3', 
       CAST(me.BillingID AS nvarchar(80)) AS 'Data4',
       '' AS 'Data5'
         
FROM Member AS me (NOLOCK)
JOIN Company AS co ON me.CompanyID = co.CompanyID

WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND me.Status = 2
AND DATEADD( day, @Days, DATEADD(day, me.TrialDays, me.EnrollDate) ) = @Now
AND me.IsMsg != 2

GO