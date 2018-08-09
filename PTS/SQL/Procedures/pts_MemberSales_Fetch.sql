EXEC [dbo].pts_CheckProc 'pts_MemberSales_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_MemberSales_Fetch ( 
   @MemberSalesID int,
   @MemberID int OUTPUT,
   @CompanyID int OUTPUT,
   @TitleName nvarchar (40) OUTPUT,
   @SalesDate datetime OUTPUT,
   @Title int OUTPUT,
   @PV money OUTPUT,
   @GV money OUTPUT,
   @PV2 money OUTPUT,
   @GV2 money OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @MemberID = ms.MemberID ,
   @CompanyID = ms.CompanyID ,
   @TitleName = ti.TitleName ,
   @SalesDate = ms.SalesDate ,
   @Title = ms.Title ,
   @PV = ms.PV ,
   @GV = ms.GV ,
   @PV2 = ms.PV2 ,
   @GV2 = ms.GV2
FROM MemberSales AS ms (NOLOCK)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (ms.CompanyID = ti.CompanyID and ms.Title = ti.TitleNo)
WHERE ms.MemberSalesID = @MemberSalesID

GO