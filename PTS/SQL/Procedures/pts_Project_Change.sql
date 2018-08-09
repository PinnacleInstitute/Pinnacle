EXEC [dbo].pts_CheckProc 'pts_Project_Change'
GO

CREATE PROCEDURE [dbo].pts_Project_Change
   @ProjectID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO