EXEC [dbo].pts_CheckProc 'pts_Attachment_EnumOrgList'
GO

CREATE PROCEDURE [dbo].pts_Attachment_EnumOrgList
   @CompanyID int ,
   @Secure int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT
GO