EXEC [dbo].pts_CheckProc 'pts_Company_CustomList_7'
GO

--EXEC pts_Company_CustomList_7 1, '1/29/13', 0, 0

CREATE PROCEDURE [dbo].pts_Company_CustomList_7
   @Status int ,
   @EnrollDate datetime ,
   @Quantity int ,
   @Amount int
AS

SET NOCOUNT ON

IF @Status = 1
BEGIN
   Select NameFirst 'Refers' FROM Member Where CompanyID = 7 AND dbo.wtfn_DateOnly(EnrollDate) = @EnrollDate
END
   
GO
