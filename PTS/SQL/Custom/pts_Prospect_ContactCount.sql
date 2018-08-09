EXEC [dbo].pts_CheckProc 'pts_Prospect_ContactCount'
GO

--DECLARE @cnt int EXEC pts_Prospect_ContactCount 6591, @cnt output print @cnt
 
CREATE PROCEDURE [dbo].pts_Prospect_ContactCount
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = COUNT(ProspectID) FROM Prospect WHERE MemberID = @MemberID AND Status < 0

GO