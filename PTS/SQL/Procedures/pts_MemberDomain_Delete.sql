EXEC [dbo].pts_CheckProc 'pts_MemberDomain_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberDomain_Delete ( 
   @MemberDomainID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE med
FROM MemberDomain AS med
WHERE med.MemberDomainID = @MemberDomainID

GO