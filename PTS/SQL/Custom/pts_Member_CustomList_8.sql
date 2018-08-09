EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_8'
GO

--EXEC pts_Member_CustomList_8 100, 4

-- Life Time
CREATE PROCEDURE [dbo].pts_Member_CustomList_8
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = 8

GO
