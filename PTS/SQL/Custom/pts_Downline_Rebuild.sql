EXEC [dbo].pts_CheckProc 'pts_Downline_Rebuild'
GO

CREATE PROCEDURE [dbo].pts_Downline_Rebuild
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

DELETE Downline WHERE ChildID = @ChildID 

EXEC pts_Downline_Build @CompanyID, @ParentID, @ChildID, @Result OUTPUT

GO