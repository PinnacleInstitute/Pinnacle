EXEC [dbo].pts_CheckProc 'pts_Commission_Email'
GO

CREATE PROCEDURE [dbo].pts_Commission_Email
   @CompanyID int ,
   @RefID int ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT      co.CommissionID, 
         co.Notes, 
         co.Description, 
         co.Total

GO