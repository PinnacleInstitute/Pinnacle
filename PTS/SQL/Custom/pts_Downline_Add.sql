EXEC [dbo].pts_CheckProc 'pts_Downline_Add'
GO

CREATE PROCEDURE [dbo].pts_Downline_Add
   @CompanyID int ,
   @Line int ,
   @ParentID int ,
   @ChildID int
AS

SET NOCOUNT ON

DECLARE @ID int, @Parent int, @Pos int

-- Check to see if the child is in the downline
SELECT @ID = DownlineID, @Parent = ParentID FROM Downline WHERE Line = @Line AND ChildID = @ChildID

-- If we found the child with a different parent, delete the downline record
IF @ID > 0 AND @Parent <> @ParentID
BEGIN
	DELETE Downline WHERE DownlineID = @ID
--	Check for a demotion of the old parent
--	IF @Line = 0 EXEC pts_Downline_Promote @CompanyID, @Parent
END

-- If we found no downline, or we found a different parent, then rebuild it
IF @ID IS NULL OR @Parent <> @ParentID
BEGIN
--	Get the next available position under this enroller
	EXEC pts_Downline_NextPosition @Line, @ParentID, @Pos OUTPUT

--	Add the new downline member under the enroller at the next position
	INSERT INTO Downline ( Line, ParentID, ChildID, Position ) VALUES ( @Line, @ParentID, @ChildID, @Pos )

--	Check for a promotion of the new parent
--	IF @Line = 0 EXEC pts_Downline_Promote @CompanyID, @ParentID
END

GO