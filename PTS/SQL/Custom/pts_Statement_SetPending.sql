EXEC [dbo].pts_CheckProc 'pts_Statement_SetPending'
GO

CREATE PROCEDURE [dbo].pts_Statement_SetPending
   @CompanyID int ,
   @PayType int ,
   @Count int OUTPUT
AS

SET NOCOUNT ON

DECLARE @Today datetime
SET @Today = dbo.wtfn_DateOnly( GETDATE() )

SELECT @Count = COUNT(*) FROM Statement
WHERE CompanyID = @CompanyID AND Status = 1 AND PayType = @PayType AND Notes <> ''

UPDATE Statement SET Status = 2, PaidDate = @Today 
WHERE CompanyID = @CompanyID AND Status = 1 AND PayType = @PayType AND Notes <> ''

GO