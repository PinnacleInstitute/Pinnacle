EXEC [dbo].pts_CheckProc 'pts_Downline_UpdateTitle_1'
GO

CREATE PROCEDURE [dbo].pts_Downline_UpdateTitle_1
   @CompanyID int ,
   @ParentID int ,
   @ChildID int ,
   @Old int ,
   @Title int 
AS

SET NOCOUNT ON



GO