EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_85'
GO

--TEST
--EXEC pts_Emailee_ListCustom_85 5, '1', '1', '', '', ''

-- Member Logon Info
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_85
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @FromTitle int, @ToTitle int

IF @Data1 = ''
	SET @FromTitle = 0
ELSE
	SET @FromTitle = CAST(@Data1 AS int)

IF @ToTitle = ''
	SET @ToTitle = 10
ELSE
	SET @ToTitle = CAST(@Data2 AS int)

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Title AS VARCHAR(4)) AS 'Data1', 
       '' AS 'Data2',
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = me.CompanyID )
AND me.Title >= @FromTitle
AND me.Title <= @ToTitle
AND ( me.Status < = 4 )
AND ( me.IsRemoved = 0 )
AND ( me.email LIKE '%@%' )
AND me.IsMsg != 2

GO
