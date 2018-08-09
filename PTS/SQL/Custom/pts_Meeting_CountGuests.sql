EXEC [dbo].pts_CheckProc 'pts_Meeting_CountGuests'
GO

CREATE PROCEDURE [dbo].pts_Meeting_CountGuests
   @MeetingID int ,
   @Result nvarchar (100) OUTPUT
AS

SET NOCOUNT ON

GO