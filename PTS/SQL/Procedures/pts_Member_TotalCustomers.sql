EXEC [dbo].pts_CheckProc 'pts_Member_TotalCustomers'
GO

CREATE PROCEDURE [dbo].pts_Member_TotalCustomers
   @MemberID int ,
   @Result int OUTPUT
AS

SET NOCOUNT ON

GO