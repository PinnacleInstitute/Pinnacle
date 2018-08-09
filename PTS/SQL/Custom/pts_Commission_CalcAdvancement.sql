EXEC [dbo].pts_CheckProc 'pts_Commission_CalcAdvancement'
GO

CREATE PROCEDURE [dbo].pts_Commission_CalcAdvancement
   @CompanyID int ,
   @OwnerID int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

IF @CompanyID = 5 EXEC pts_Commission_CalcAdvancement_5 @OwnerID, 0, @Count OUTPUT

--IF @CompanyID = 2 EXEC pts_Commission_CalcAdvancement_2 @OwnerID, @Count OUTPUT
--IF @CompanyID = 6 EXEC pts_Commission_CalcAdvancement_6 @OwnerID, @Count OUTPUT
--IF @CompanyID = 7 EXEC pts_Commission_CalcAdvancement_7 @OwnerID, @Count OUTPUT
--IF @CompanyID = 12 EXEC pts_Commission_CalcAdvancement_12 @OwnerID, @Count OUTPUT

GO