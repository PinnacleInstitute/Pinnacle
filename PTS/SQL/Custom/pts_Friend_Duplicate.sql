EXEC [dbo].pts_CheckProc 'pts_Friend_Duplicate'
GO

CREATE PROCEDURE [dbo].pts_Friend_Duplicate
   @Result int OUTPUT ,
   @Email varchar(80)
   
AS

SET NOCOUNT ON

SELECT @Result = COUNT(*) FROM Friend WHERE Email = @Email

GO