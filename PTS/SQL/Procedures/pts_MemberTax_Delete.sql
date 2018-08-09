EXEC [dbo].pts_CheckProc 'pts_MemberTax_Delete'
 GO

CREATE PROCEDURE [dbo].pts_MemberTax_Delete ( 
   @MemberTaxID int,
   @UserID int
      )
AS


SET NOCOUNT ON


DELETE mtx
FROM MemberTax AS mtx
WHERE mtx.MemberTaxID = @MemberTaxID

GO