EXEC [dbo].pts_CheckProc 'pts_Member_RefRef'
GO
--declare @R int EXEC pts_Member_RefRef 7, '61939020z', @R output print @R

CREATE PROCEDURE [dbo].pts_Member_RefRef
   @CompanyID int ,
   @Reference nvarchar (15),
   @ReferralID int OUTPUT
AS

SET NOCOUNT ON
SET @ReferralID = 0
SELECT @ReferralID = ISNULL(MemberID,0) FROM Member WHERE CompanyID = @CompanyID AND Reference = @Reference

GO
