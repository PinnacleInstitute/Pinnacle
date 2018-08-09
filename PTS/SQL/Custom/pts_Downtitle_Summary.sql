EXEC [dbo].pts_CheckProc 'pts_Downtitle_Summary'
GO

CREATE PROCEDURE [dbo].pts_Downtitle_Summary
   @Line int ,
   @MemberID int
AS

SET NOCOUNT ON

SELECT  dt.Title , 
        ti.TitleName AS 'TitleName' ,
	MIN(dt.DowntitleID) 'DowntitleID' , 
        COUNT(dt.Leg) 'Leg', 
        SUM(dt.Cnt) 'Cnt' 
FROM Downtitle AS dt (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (dt.MemberID = me.MemberID)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (me.CompanyID = ti.CompanyID AND dt.Title = ti.TitleNo)
WHERE dt.Line = @Line AND dt.MemberID = @MemberID AND dt.Cnt > 0

GROUP BY dt.Title, ti.TitleName
ORDER BY dt.Title

GO

