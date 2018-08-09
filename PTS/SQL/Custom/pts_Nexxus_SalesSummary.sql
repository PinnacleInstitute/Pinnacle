EXEC [dbo].pts_CheckProc 'pts_Nexxus_SalesSummary'
GO

-- EXEC pts_Nexxus_SalesSummary

CREATE PROCEDURE [dbo].pts_Nexxus_SalesSummary
AS

SET NOCOUNT ON
DECLARE @ID int, @MemberID int, @CompanyID int, @SalesDate datetime, @Title int, @PV money, @GV money, @PV2 money, @GV2 money
SET @CompanyID = 21
SET @SalesDate = dbo.wtfn_DateOnly(GETDATE())

DECLARE Member_Cursor CURSOR LOCAL STATIC FOR 
SELECT MemberID, Title, BV, QV, BV2, QV2 FROM Member 
WHERE companyid = 21 and status >= 1 and status <= 4 and title > 1 
--AND MemberID = 37702

OPEN Member_Cursor
FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @PV, @GV, @PV2, @GV2 
WHILE @@FETCH_STATUS = 0
BEGIN
	EXEC pts_MemberSales_Add @ID, @MemberID, @CompanyID, @SalesDate, @Title, @PV, @GV, @PV2, @GV2,1
	FETCH NEXT FROM Member_Cursor INTO @MemberID, @Title, @PV, @GV, @PV2, @GV2	
END
CLOSE Member_Cursor
DEALLOCATE Member_Cursor

GO
