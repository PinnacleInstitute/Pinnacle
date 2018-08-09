EXEC [dbo].pts_CheckProc 'pts_GCR_TrialPlacement'
GO

CREATE PROCEDURE [dbo].pts_GCR_TrialPlacement
   @MemberID int 
AS

SET NOCOUNT ON

DECLARE @Status int, @ReferralID int , @Result int 

SELECT @ReferralID = ReferralID FROM Member WHERE MemberID = @MemberID

EXEC pts_GCR_QualifiedMember @MemberID, 1, 0, @Result
EXEC pts_GCR_Placement @MemberID
EXEC pts_Commission_CalcAdvancement_17 @ReferralID, 0, @Result OUTPUT


GO 
