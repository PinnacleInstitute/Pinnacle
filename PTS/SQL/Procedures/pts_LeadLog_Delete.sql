EXEC [dbo].pts_CheckProc 'pts_LeadLog_Delete'
 GO

CREATE PROCEDURE [dbo].pts_LeadLog_Delete ( 
   @LeadLogID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE ll
FROM LeadLog AS ll
WHERE ll.LeadLogID = @LeadLogID

GO