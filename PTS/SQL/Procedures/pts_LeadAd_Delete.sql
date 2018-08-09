EXEC [dbo].pts_CheckProc 'pts_LeadAd_Delete'
 GO

CREATE PROCEDURE [dbo].pts_LeadAd_Delete ( 
   @LeadAdID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE la
FROM LeadAd AS la
WHERE la.LeadAdID = @LeadAdID

GO