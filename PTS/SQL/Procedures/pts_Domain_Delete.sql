EXEC [dbo].pts_CheckProc 'pts_Domain_Delete'
 GO

CREATE PROCEDURE [dbo].pts_Domain_Delete ( 
   @DomainID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE dom
FROM Domain AS dom
WHERE dom.DomainID = @DomainID

GO