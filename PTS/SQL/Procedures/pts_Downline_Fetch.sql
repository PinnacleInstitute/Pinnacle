EXEC [dbo].pts_CheckProc 'pts_Downline_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Downline_Fetch ( 
   @DownlineID int,
   @Line int OUTPUT,
   @ParentID int OUTPUT,
   @ChildID int OUTPUT,
   @Position int OUTPUT,
   @IsLocked bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @Line = dl.Line ,
   @ParentID = dl.ParentID ,
   @ChildID = dl.ChildID ,
   @Position = dl.Position ,
   @IsLocked = dl.IsLocked
FROM Downline AS dl (NOLOCK)
WHERE dl.DownlineID = @DownlineID

GO