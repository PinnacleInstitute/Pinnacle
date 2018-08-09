EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_205'
GO

--TEST
--EXEC pts_Emailee_ListCustom_205 5, '6/15/12', '', '', '', ''

-- CloudZow Computers with No Backup Data older than Data1
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_205
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
	SET @Now = CAST(@Data1 AS datetime)
Else
	SET @Now = dbo.wtfn_DateOnly(GETDATE())

SELECT ma.MachineID AS 'EmaileeID', 
       ma.Email AS 'Email', 
       ma.NameFirst AS 'FirstName', 
       ma.NameLast AS 'LastName', 
       dbo.wtfn_DateOnlyStr(ma.ActiveDate) AS 'Data1', 
       CAST(me.Process AS varchar(2)) AS 'Data2',
       me.Email AS 'Data3',
       CAST(me.Status AS varchar(2)) AS 'Data4',
       CAST(me.Level AS varchar(2)) AS 'Data5'
FROM Machine AS ma (NOLOCK)
JOIN Member AS me ON ma.MemberID = me.MemberID
WHERE me.Status >= 1 AND me.Status <= 4 AND me.GroupID <> 100
AND ma.Status = 2 AND ma.BackupUsed = '0 B'
AND ma.ActiveDate <= @Now
 
GO
