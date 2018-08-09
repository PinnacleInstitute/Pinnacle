EXEC [dbo].pts_CheckProc 'pts_Lead_UpdateCode'
GO

CREATE PROCEDURE [dbo].pts_Lead_UpdateCode
   @LeadID int ,
   @Code int
AS

SET NOCOUNT ON

UPDATE Lead SET Code = @Code WHERE LeadID = @LeadID

GO