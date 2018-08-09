EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_84'
GO

--TEST
--EXEC pts_Emailee_ListCustom_84 582, '5', '10', '', '', ''

-- Member Logon Info
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_84
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @VisitDate datetime

IF @Data1 = ''
	SET @VisitDate = 0
ELSE
	SET @VisitDate = CAST(@Data1 AS datetime)


SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       me.VisitDate AS 'Data1', 
       '' AS 'Data2',
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = me.CompanyID )
AND me.VisitDate > @VisitDate
AND ( me.Status < 4 )
AND ( me.IsRemoved = 0 )
AND ( me.email LIKE '%@%' )
AND me.IsMsg != 2

GO
