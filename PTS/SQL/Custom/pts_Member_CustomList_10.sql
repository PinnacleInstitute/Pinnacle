EXEC [dbo].pts_CheckProc 'pts_Member_CustomList_10'
GO

--EXEC pts_Member_CustomList_10 100, 4

CREATE PROCEDURE [dbo].pts_Member_CustomList_10
   @Status int ,
   @Level int
AS

SET NOCOUNT ON
DECLARE @CompanyID int
SET @CompanyID = 10


GO
