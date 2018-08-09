EXEC [dbo].pts_CheckProc 'pts_Company_2_Advancement'
GO

CREATE PROCEDURE [dbo].pts_Company_2_Advancement
AS

DECLARE @Count int

EXEC pts_Company_Custom_2 1, 0, 0, 0, @Count OUTPUT
PRINT @Count

EXEC pts_Commission_CalcAdvancement_2 @Count OUTPUT
PRINT @Count

GO