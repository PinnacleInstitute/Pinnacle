EXEC [dbo].pts_CheckProc 'pts_LeadPage_Delete'
 GO

CREATE PROCEDURE [dbo].pts_LeadPage_Delete ( 
   @LeadPageID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE lp
FROM LeadPage AS lp
WHERE lp.LeadPageID = @LeadPageID

GO