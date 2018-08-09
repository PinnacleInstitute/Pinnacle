EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_78'
GO

--EXEC pts_Emailee_ListCustom_78 7, '', '', '', '', ''

-- ******************************
-- Temp List
-- ------------------------------
-- Data1 = Member # (0)
-- Data2 = Team # (all)
-- Data3 = From Date (0)
-- Data4 = To Date (Today)
-- ******************************
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_78
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @MemberID int, @Team int, @ToDate datetime, @FromDate datetime

IF @Data1 = ''
	SET @MemberID = 0
ELSE
	SET @MemberID = CAST(@Data1 AS int)

IF @Data2 = ''
	SET @Team = 0
ELSE
	SET @Team = CAST(@Data2 AS int)

IF @Data3 = ''
	SET @FromDate = 0
ELSE
	SET @FromDate = CAST(@Data3 AS datetime)

IF @Data4 = ''
	SET @ToDate = dbo.wtfn_DateOnly( GETDATE() )
ELSE
	SET @ToDate = CAST(@Data4 AS datetime)

SET @ToDate = DATEADD(d, 1, @ToDate)
	
SELECT DISTINCT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.EnrollDate AS VARCHAR(20)) AS 'Data1',
       '' AS 'Data2',
       '' AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
from Member AS me
where me.CompanyID = @CompanyID
AND GroupID IN (9887,6528,9096,9399,9401)
AND me.Status >= 1 AND me.Status <= 4
AND me.IsMsg != 2

GO
