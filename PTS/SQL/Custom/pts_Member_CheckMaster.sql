EXEC [dbo].pts_CheckProc 'pts_Member_CheckMaster'
GO

CREATE PROCEDURE [dbo].pts_Member_CheckMaster
   @MasterID int ,
   @CompanyID int ,
   @MemberID int OUTPUT
AS

SET NOCOUNT ON

SELECT @MemberID = ISNULL(MemberID,0) FROM Member WHERE MemberID = @MasterID AND CompanyID = @CompanyID AND IsMaster = 1

GO