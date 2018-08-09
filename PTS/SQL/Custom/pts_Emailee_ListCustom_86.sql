EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_86'
GO

--TEST
--EXEC pts_Emailee_ListCustom_86 17, '', '', '', '', ''

-- Member Logon Info
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_86
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Start int, @End int

IF @Data1 = ''
	SET @Start = 0
ELSE
	SET @Start = CAST(@Data1 AS int)

IF @Data2 = ''
	SET @End = 100000000
ELSE
	SET @End = CAST(@Data2 AS int)

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       au.Logon AS 'Data1', 
       au.Password AS 'Data2',
       CAST(me.memberid AS VARCHAR(20)) AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
WHERE ( @CompanyID = me.CompanyID )
AND me.MemberID >= @Start
AND me.MemberID <= @End
AND ( me.Status >= 1 )
AND ( me.Status <= 4 )
AND ( me.IsRemoved = 0 )
AND ( me.email LIKE '%@%' )
AND me.IsMsg != 2
--This must be removed by a programmer due to sensitive security info
--AND me.MemberID > 0
--AND me.MemberID <= 25000 
--AND me.MemberID > 25000
--AND me.MemberID <= 30000 
--AND me.MemberID > 30000
--AND me.MemberID <= 40000 

AND 1 = 0

GO
