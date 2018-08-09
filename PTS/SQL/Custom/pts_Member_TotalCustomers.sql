EXEC [dbo].pts_CheckProc 'pts_Member_TotalCustomers'
GO

--DECLARE @Count int EXEC pts_Member_TotalCustomers 521, @Count OUTPUT PRINT @Count

CREATE PROCEDURE [dbo].pts_Member_TotalCustomers
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

SELECT @Result = COUNT(*) FROM Member WHERE ReferralID = @MemberID AND Status >= 1 AND Status <= 3 AND Level = 0

GO
