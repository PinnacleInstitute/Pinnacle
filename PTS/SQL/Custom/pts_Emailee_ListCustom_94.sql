EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_94'
GO

--TEST
--EXEC pts_Emailee_ListCustom_94 13, '', '', '', '', ''

-- Member Last Visit Day
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_94
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
       dbo.wtfn_DateOnlyStr(me.VisitDate) AS 'Data2', 
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND DATEADD( day, @Days, dbo.wtfn_DateOnly(me.VisitDate)) = @Now
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
