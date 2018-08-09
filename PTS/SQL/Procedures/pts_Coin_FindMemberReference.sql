EXEC [dbo].pts_CheckProc 'pts_Coin_FindMemberReference'
 GO

CREATE PROCEDURE [dbo].pts_Coin_FindMemberReference ( 
   @SearchText varchar (30),
   @Bookmark varchar (40),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @FromDate datetime,
   @ToDate datetime,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(coi.Reference, '') + dbo.wtfn_FormatNumber(coi.CoinID, 10) 'BookMark' ,
            coi.CoinID 'CoinID' ,
            coi.CompanyID 'CompanyID' ,
            coi.MemberID 'MemberID' ,
            coi.CoinDate 'CoinDate' ,
            coi.Amount 'Amount' ,
            coi.Status 'Status' ,
            coi.CoinType 'CoinType' ,
            coi.Reference 'Reference' ,
            coi.Notes 'Notes'
FROM Coin AS coi (NOLOCK)
WHERE ISNULL(coi.Reference, '') LIKE '%' + @SearchText + '%'
AND ISNULL(coi.Reference, '') + dbo.wtfn_FormatNumber(coi.CoinID, 10) >= @BookMark
AND         (coi.MemberID = @MemberID)
AND         (coi.CoinDate >= @FromDate)
AND         (coi.CoinDate <= @ToDate)
ORDER BY 'Bookmark'

GO