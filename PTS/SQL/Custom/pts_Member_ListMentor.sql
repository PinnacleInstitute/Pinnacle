EXEC [dbo].pts_CheckProc 'pts_Member_ListMentor'
GO

--EXEC pts_Member_ListMentor 39060, 0

CREATE PROCEDURE [dbo].pts_Member_ListMentor
   @MentorID int ,
   @VisitDate datetime 
AS

SET NOCOUNT ON

SELECT  me.MemberID, 
        me.CompanyID, 
        me.NameLast, 
        me.NameFirst, 
        me.VisitDate, 
        me.EnrollDate, 
        me.Status, 
        me.Email, 
        me.Options, 
	CASE level
	      WHEN 0 THEN co.FreeOptions
	      WHEN 1 THEN co.Options
	      WHEN 2 THEN co.Options2
	      WHEN 3 THEN co.Options3
	      ELSE co.Options
	   END AS Unit, 
        me.NotifyMentor,
	(
		SELECT COUNT(nt.noteid)
		FROM Note AS nt
		WHERE nt.OwnerType = -4 AND nt.OwnerID = me.MemberID AND nt.NoteDate > @VisitDate
	) 'Quantity',
	me.Image

FROM Member AS me (NOLOCK)
JOIN Coption AS co ON me.CompanyID = co.CompanyID
WHERE (me.MentorID = @MentorID)
AND (me.IsRemoved = 0)
AND (me.Status < 5)

ORDER BY me.NameLast, me.NameFirst

GO

