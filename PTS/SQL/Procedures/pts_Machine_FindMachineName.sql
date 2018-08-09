EXEC [dbo].pts_CheckProc 'pts_Machine_FindMachineName'
 GO

CREATE PROCEDURE [dbo].pts_Machine_FindMachineName ( 
   @SearchText nvarchar (62),
   @Bookmark nvarchar (72),
   @MaxRows tinyint OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(LTRIM(RTRIM(mc.NameLast)) +  ', '  + LTRIM(RTRIM(mc.NameFirst)), '') + dbo.wtfn_FormatNumber(mc.MachineID, 10) 'BookMark' ,
            mc.MachineID 'MachineID' ,
            mc.MemberID 'MemberID' ,
            me.NameFirst 'MemberNameFirst' ,
            me.NameLast 'MemberNameLast' ,
            me.Email 'MemberEmail' ,
            mc.LiveDriveID 'LiveDriveID' ,
            mc.NameLast 'NameLast' ,
            mc.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(mc.NameLast)) +  ', '  + LTRIM(RTRIM(mc.NameFirst)) 'MachineName' ,
            mc.Email 'Email' ,
            mc.Password 'Password' ,
            mc.WebName 'WebName' ,
            mc.Status 'Status' ,
            mc.Service 'Service' ,
            mc.ActiveDate 'ActiveDate' ,
            mc.CancelDate 'CancelDate' ,
            mc.RemoveDate 'RemoveDate' ,
            mc.BackupUsed 'BackupUsed' ,
            mc.BackupCapacity 'BackupCapacity' ,
            mc.BriefcaseUsed 'BriefcaseUsed' ,
            mc.BriefcaseCapacity 'BriefcaseCapacity' ,
            mc.Qty 'Qty'
FROM Machine AS mc (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (mc.MemberID = me.MemberID)
WHERE ISNULL(LTRIM(RTRIM(mc.NameLast)) +  ', '  + LTRIM(RTRIM(mc.NameFirst)), '') LIKE @SearchText + '%'
AND ISNULL(LTRIM(RTRIM(mc.NameLast)) +  ', '  + LTRIM(RTRIM(mc.NameFirst)), '') + dbo.wtfn_FormatNumber(mc.MachineID, 10) >= @BookMark
ORDER BY 'Bookmark'

GO