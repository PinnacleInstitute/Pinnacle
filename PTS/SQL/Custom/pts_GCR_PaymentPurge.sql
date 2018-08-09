EXEC [dbo].pts_CheckProc 'pts_GCR_PaymentPurge'
GO

--declare @Result varchar(1000) EXEC pts_GCR_PaymentPurge 

CREATE PROCEDURE [dbo].pts_GCR_PaymentPurge
AS

SET NOCOUNT ON

delete pa
from payment as pa
where ownertype = 4 and ownerid IN
( select me.memberid from Member as me
where me.CompanyID = 17
and 1 < (select COUNT(*) from Payment where ownertype = 4 and OwnerID = me.MemberID and Status = 1)
)
and PayDate < (select top 1 PayDate from Payment where ownertype = 4 and ownerid = pa.OwnerID and Status = 1 order by PayDate desc)
and Status = 1

GO

