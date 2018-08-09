EXEC [dbo].pts_CheckProc 'pts_Downline_Update'
 GO

CREATE PROCEDURE [dbo].pts_Downline_Update ( 
   @DownlineID int,
   @Line int,
   @ParentID int,
   @ChildID int,
   @Position int,
   @IsLocked bit,
   @UserID int
      )
AS

DECLARE @mNow datetime

SET NOCOUNT ON

SET @mNow = GETDATE()

UPDATE dl
SET dl.Line = @Line ,
   dl.ParentID = @ParentID ,
   dl.ChildID = @ChildID ,
   dl.Position = @Position ,
   dl.IsLocked = @IsLocked
FROM Downline AS dl
WHERE dl.DownlineID = @DownlineID

GO