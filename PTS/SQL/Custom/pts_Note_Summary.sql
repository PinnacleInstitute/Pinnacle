EXEC [dbo].pts_CheckProc 'pts_Note_Summary'
GO

--EXEC pts_Note_Summary 2, 0, '1/1/00', '1/1/06' 

CREATE PROCEDURE [dbo].pts_Note_Summary
   @OwnerType int ,
   @IsReminder bit ,
   @FromDate datetime ,
   @ToDate datetime
AS

SET NOCOUNT ON

SELECT  nt.AuthUserID AS 'NoteID', 
        au.NameFirst +  ' '  + au.NameLast AS 'UserName', 
        COUNT(*) AS 'Num'
FROM Note AS nt
JOIN AuthUser AS au ON nt.AuthUserID = au.AuthUserID
WHERE au.UserType = @OwnerType
AND nt.IsReminder = @IsReminder
AND nt.NoteDate >= @FromDate
AND nt.NoteDate <= @ToDate
GROUP BY nt.AuthUserID, au.NameFirst +  ' ' + au.NameLast 
ORDER BY Num DESC

GO
