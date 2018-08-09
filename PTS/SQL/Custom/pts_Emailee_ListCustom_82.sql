EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_82'
GO

--TEST
--EXEC pts_Emailee_ListCustom_82 6, '6/3/11', '', '', '', ''

-- Member Logon Info
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_82
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @PaidDate datetime, @Level int, @Title int, @DateStr varchar(20)

IF @Data1 = ''
	SET @PaidDate = dbo.wtfn_DateOnly( GETDATE() )
ELSE
	SET @PaidDate = CAST(@Data1 AS datetime)
	
IF @Data2 = ''
	SET @Level = 0
ELSE
	SET @Level = CAST(@Data2 AS int)
	
IF @Data3 = ''
	SET @Title = 0
ELSE
	SET @Title = CAST(@Data3 AS int)

SET @DateStr = dbo.wtfn_DateOnlyStr( @PaidDate )

SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       Min(@DateStr) AS 'Data1', 
       SUM(pa.Amount) AS 'Data2',
       MIN('') AS 'Data3',
       MIN('') AS 'Data4',
       MIN('') AS 'Data5'
FROM Member AS me (NOLOCK)
JOIN Payout AS pa ON me.MemberID = pa.OwnerID AND pa.OwnerType = 4
WHERE ( @CompanyID = me.CompanyID )
AND pa.PaidDate = @PaidDate
AND ( @Level = 0 OR me.Level = @Level )
AND ( @Title = 0 OR me.Title = @Title )
AND ( me.Status < 4 )
AND ( me.IsRemoved = 0 )
AND ( me.email LIKE '%@%' )
AND me.IsMsg != 2
GROUP BY me.MemberID, me.Email, me.NameFirst, me.NameLast
HAVING SUM(pa.Amount) > 0
GO
