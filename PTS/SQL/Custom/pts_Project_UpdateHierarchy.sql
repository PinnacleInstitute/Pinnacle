EXEC [dbo].pts_CheckProc 'pts_Project_UpdateHierarchy'
GO

CREATE PROCEDURE [dbo].pts_Project_UpdateHierarchy
   @ProjectID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON
SET @Result = 0

DECLARE @CompanyID int, @Str varchar(30), @Hier varchar(30), @ParentID int

SELECT @CompanyID = CompanyID, @Hier = Hierarchy, @ParentID = ParentID FROM Project WHERE ProjectID = @ProjectID

IF @ParentID = 0
	SET @Str = CAST(@ProjectID AS VARCHAR(10)) + '/'
ELSE
	SET @Str = @Hier

--print CAST(@ProjectID as varchar(10)) + ' :: ' + @Str

IF @Str != @Hier 
	UPDATE Project SET Hierarchy = @Str WHERE ProjectID = @ProjectID

EXEC pts_Project_SetHierarchy @CompanyID, @ProjectID, @Str

GO
