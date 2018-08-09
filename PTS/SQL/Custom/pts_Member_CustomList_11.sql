EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_11'
GO

--EXEC pts_Member_CustomList_11 80, 0

CREATE PROCEDURE [dbo].pts_Member_CustomList_11
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = 11

-- Get Member Sales Volume
IF @Status = 80
BEGIN
	Select MemberID 'MemberID', Status AS 'Status', Title 'Level',
	NameFirst + ' ' + NameLast  + ' #' + CAST(MemberID AS VARCHAR(10)) + ', ' + CAST(BV2 AS VARCHAR(10)) + ', ' + CAST(QV2 AS VARCHAR(10)) + ', ' + CAST( (CASE WHEN QV2-BV2 < 0 THEN 0 ELSE QV2-BV2 END) AS VARCHAR(10)) AS 'Signature' 
	FROM Member
	WHERE CompanyID = @CompanyID AND Status >= 1 AND Status <= 4
	ORDER BY EnrollDate
END

GO
