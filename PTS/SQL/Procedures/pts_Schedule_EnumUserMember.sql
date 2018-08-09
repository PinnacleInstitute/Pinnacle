EXEC [dbo].pts_CheckProc 'pts_Schedule_EnumUserMember'
GO

CREATE PROCEDURE [dbo].pts_Schedule_EnumUserMember
   @MemberID int ,
   @UserID int
AS

SET NOCOUNT ON

SELECT      sch.ScheduleID AS 'ID', 
         sch.ScheduleName AS 'Name'
FROM Schedule AS sch (NOLOCK)
WHERE (sch.MemberID = @MemberID)

ORDER BY   sch.ScheduleName

GO