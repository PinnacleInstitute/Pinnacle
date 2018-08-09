EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_97'
GO

--TEST
--EXEC pts_Emailee_ListCustom_97 13, '2', '', '', '', ''

-- Business Memberships
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_97
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @Status int

IF @Data1 != '' 
	SET @Status = CAST(@Data1 AS int)
Else
	SET @Status = 0

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.Status AS nvarchar(20)) AS 'Data1', 
       dbo.wtfn_DateOnlyStr(me.EnrollDate) AS 'Data2', 
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
FROM Member AS me (NOLOCK)
WHERE ( @CompanyID = 0 OR @CompanyID = me.CompanyID )
AND ( @Status = 0 OR @Status = me.Status )
AND ( me.IsMaster = 1 )
AND ( me.IsRemoved = 0 )
AND me.IsMsg != 2

GO
