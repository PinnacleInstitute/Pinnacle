EXEC [dbo].pts_CheckProc 'pts_Contest_LockedContest'
GO

CREATE PROCEDURE [dbo].pts_Contest_LockedContest
   @CompanyID int ,
   @GroupID int ,
   @MemberID int ,
   @StartDate datetime ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO