EXEC [dbo].pts_CheckProc 'pts_Project_SetHierarchy'
GO

CREATE PROCEDURE [dbo].pts_Project_SetHierarchy
   @CompanyID int ,
   @ProjectID int ,
   @Hierarchy varchar(30)
AS

SET NOCOUNT ON
DECLARE @Str varchar(30), @ID int, @Hier varchar(30)

DECLARE Project_cursor CURSOR LOCAL STATIC FOR 
SELECT  ProjectID, Hierarchy FROM Project
WHERE CompanyID = @CompanyID AND ParentID = @ProjectID

OPEN Project_cursor
FETCH NEXT FROM Project_cursor INTO @ID, @Hier

WHILE @@FETCH_STATUS = 0
BEGIN
	SET @Str = @Hierarchy + CAST(@ID AS VARCHAR(10)) + '/'	

--print CAST(@ID as varchar(10)) + ' : ' + @Str

	IF @Str != @Hier 
		UPDATE Project SET Hierarchy = @Str WHERE ProjectID = @ID

	EXEC pts_Project_SetHierarchy @CompanyID, @ID, @Str 

	FETCH NEXT FROM Project_cursor INTO @ID, @Str
END

CLOSE Project_cursor
DEALLOCATE Project_cursor

GO