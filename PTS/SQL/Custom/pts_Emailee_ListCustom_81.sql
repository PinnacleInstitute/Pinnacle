EXEC [dbo].pts_CheckProc 'pts_Emailee_ListCustom_81'
GO

--EXEC pts_Emailee_ListCustom_81 21, '', '', '', '', ''

-- ******************************
-- Declined Payments
-- ------------------------------
-- Data1 = From Date (0)
-- Data2 = To Date (Today)
-- Data3 = Visit Days (0)
-- Data4 = Level (all)
-- ******************************
CREATE PROCEDURE [dbo].pts_Emailee_ListCustom_81
   @CompanyID int ,
   @Data1 nvarchar (80) ,
   @Data2 nvarchar (80) ,
   @Data3 nvarchar (80) ,
   @Data4 nvarchar (80) ,
   @Data5 nvarchar (80)
AS

SET NOCOUNT ON

DECLARE @ToDate datetime, @FromDate datetime, @VisitDate datetime, @Days int, @Level int

IF @Data1 = ''
	SET @FromDate = 0
ELSE
	SET @FromDate = CAST(@Data1 AS datetime)

IF @Data2 = ''
	SET @ToDate = dbo.wtfn_DateOnly( GETDATE() )
ELSE
	SET @ToDate = CAST(@Data2 AS datetime)

SET @ToDate = DATEADD(d, 1, @ToDate)
	
IF @Data3 = ''
	SET @Days = 0
ELSE
	SET @Days = CAST(@Data3 AS int)

SET @VisitDate = DATEADD(d, @Days * -1, @ToDate)

SET @Level = -1
IF @Data4 != '' SET @Level = CAST(@Data4 AS int)

SELECT pa.PaymentID AS 'EmaileeID', 
       me.Email AS 'Email', 
       me.NameFirst AS 'FirstName', 
       me.NameLast AS 'LastName', 
       CAST(pa.Amount AS VARCHAR(10)) AS 'Data1', 
       CAST(pa.PayDate AS VARCHAR(20)) AS 'Data2',
       CAST(me.VisitDate AS VARCHAR(20)) AS 'Data3',
       '' AS 'Data4',
       '' AS 'Data5'
from payment as pa (NOLOCK)
join Member as me on pa.OwnerID = me.Memberid
where me.companyid = @CompanyID and pa.Status = 4
AND pa.OwnerType = 4
AND pa.PayDate >= @FromDate
AND pa.PayDate < @ToDate
AND me.Status >= 1 AND me.Status <= 4 AND groupid <> 100
AND ( @Level = -1 OR @Level = me.Level )
AND me.VisitDate <= @VisitDate
AND me.IsMsg != 2

GO
