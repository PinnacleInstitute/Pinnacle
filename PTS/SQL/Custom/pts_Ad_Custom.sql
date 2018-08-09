EXEC [dbo].pts_CheckProc 'pts_Ad_Custom'
GO

CREATE PROCEDURE [dbo].pts_Ad_Custom
   @CompanyID int ,
   @Status int ,
   @AdID int ,
   @Places int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO