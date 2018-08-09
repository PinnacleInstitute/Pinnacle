EXEC [dbo].pts_CheckProc 'pts_BinarySale_ListSale'
GO

CREATE PROCEDURE [dbo].pts_BinarySale_ListSale
   @MemberID int ,
   @Status int ,
   @SaleDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT   bs.BinarySaleID, 
         bs.SaleID, 
         bs.Pos, 
         bs.Status, 
         bs.StatusDate, 
         me.NameFirst + ' ' + me.NameLast AS 'SaleName', 
         me.EnrollDate AS 'SaleDate'
FROM BinarySale AS bs
JOIN Member AS me ON bs.SaleID = me.MemberID
WHERE bs.MemberID = @MemberID
AND bs.Status = @Status
AND me.EnrollDate >= @SaleDate
AND me.EnrollDate <= @ToDate
ORDER BY me.EnrollDate

GO