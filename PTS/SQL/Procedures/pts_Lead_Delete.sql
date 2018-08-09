EXEC [dbo].pts_CheckProc 'pts_Lead_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Lead_Delete ( 
   @LeadID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ld
FROM Lead AS ld
WHERE ld.LeadID = @LeadID

GO