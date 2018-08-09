EXEC [dbo].pts_CheckProc 'pts_Member_CustomList'
GO

CREATE PROCEDURE [dbo].pts_Member_CustomList
   @CompanyID int ,
   @Status int ,
   @Level int
AS

SET NOCOUNT ON

SELECT      me.MemberID, 
         me.Status, 
         me.Level, 
         me.Signature

GO