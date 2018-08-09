EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_80'
GO

--EXEC pts_Emailee_ListCustom_80 17, '', '', '', '', ''

-- ******************************
-- Binary Members
-- ------------------------------
-- Data1 = From Date (0)
-- Data2 = To Date (Today)
-- ******************************
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_80
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @ToDate datetime, @FromDate datetime, @Exclude int

IF @Data1 = ''
	SET @FromDate = 0
ELSE
	SET @FromDate = CAST(@Data1 AS datetime)

IF @Data2 = ''
	SET @ToDate = dbo.wtfn_DateOnly( GETDATE() )
ELSE
	SET @ToDate = CAST(@Data2 AS datetime)

SET @Exclude = CAST(@Data3 AS int)

SET @ToDate = DATEADD(d, 1, @ToDate)
	
SELECT me.MemberID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(me.ReferralID AS VARCHAR(10)) AS 'Data1', 
       CAST(me.Sponsor3ID AS VARCHAR(20)) AS 'Data2',
       au.Logon AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
from Member as me (NOLOCK)
JOIN AuthUser AS au ON me.AuthUserID = au.AuthUserID
where me.companyid = @CompanyID
AND ( (@Exclude=0 AND me.Sponsor3ID!=0) OR (@Exclude!=0 AND me.Sponsor3ID=0) )
AND me.EnrollDate >= @FromDate
AND me.EnrollDate < @ToDate
AND me.Status >= 1 AND me.Status <= 4
AND me.IsMsg != 2

GO
