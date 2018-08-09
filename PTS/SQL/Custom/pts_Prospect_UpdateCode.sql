EXEC [dbo].pts_CheckProc 'pts_Prospect_UpdateCode'
GO

CREATE PROCEDURE [dbo].pts_Prospect_UpdateCode
   @ProspectID int ,
   @Code int
AS

SET NOCOUNT ON

UPDATE Prospect SET Code = @Code WHERE ProspectID = @ProspectID

GO
