EXEC [dbo].pts_CheckProc 'pts_Party_CalcSales'
GO

CREATE PROCEDURE [dbo].pts_Party_CalcSales
   @PartyID int
AS

SET NOCOUNT ON

DECLARE @Sales money

SELECT @Sales = SUM(Sale) FROM Guest WHERE PartyID = @PartyID

UPDATE PARTY SET Sales = @Sales WHERE PartyID = @PartyID

GO