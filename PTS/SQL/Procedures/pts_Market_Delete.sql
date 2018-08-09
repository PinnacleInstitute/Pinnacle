EXEC [dbo].pts_CheckProc 'pts_Market_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Market_Delete ( 
   @MarketID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mar
FROM Market AS mar
WHERE mar.MarketID = @MarketID

GO