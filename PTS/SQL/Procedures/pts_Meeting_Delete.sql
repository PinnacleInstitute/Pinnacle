EXEC [dbo].pts_CheckProc 'pts_Meeting_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Meeting_Delete ( 
   @MeetingID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mtg
FROM Meeting AS mtg
WHERE mtg.MeetingID = @MeetingID

GO