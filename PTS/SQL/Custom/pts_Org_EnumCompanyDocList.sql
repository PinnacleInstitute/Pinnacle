EXEC [dbo].pts_CheckProc 'pts_Org_EnumCompanyDocList'
GO

--EXEC pts_Org_EnumCompanyDocList 13, 1, 1

CREATE PROCEDURE [dbo].pts_Org_EnumCompanyDocList
   @CompanyID int ,
   @Secure int ,
   @UserID int
AS

SET NOCOUNT ON

DECLARE @Now datetime
SET @Now = GETDATE()

SELECT OrgID 'ID', OrgName 'Name' FROM Org WHERE CompanyID = @CompanyID
AND 0 < (
	SELECT Count(AttachmentID) FROM Attachment
	WHERE ParentType = 28 AND ParentID = Org.OrgID
	AND CompanyID = @CompanyID
	AND Secure <= @Secure
	AND (ExpireDate = 0 OR ExpireDate > @Now)
	AND Status = 1
)
ORDER BY OrgName

GO