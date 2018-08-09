EXEC [dbo].pts_CheckProc 'pts_Member_MentorTeam'
GO

CREATE PROCEDURE [dbo].pts_Member_MentorTeam
   @MemberID int 

AS

Select A.MemberID, A.MentorID, A.NameFirst + ' ' + A.NameLast 'CompanyName', A.Phone1, A.Email, A.EnrollDate, A.VisitDate From Member As A
Where A.MentorID = @MemberID
Union All
Select B.MemberID, B.MentorID, B.NameFirst + ' ' + B.NameLast 'CompanyName', B.Phone1, B.Email, B.EnrollDate, B.VisitDate From Member As A
Join Member As B On A.MemberID = B.MentorID
Where A.MentorID = @MemberID
Union All
Select C.MemberID, C.MentorID, C.NameFirst + ' ' + C.NameLast 'CompanyName', C.Phone1, C.Email, C.EnrollDate, C.VisitDate From Member As A
Join Member As B On A.MemberID = B.MentorID
Join Member As C On B.MemberID = C.MentorID
Where A.MentorID = @MemberID
Union All
Select D.MemberID, D.MentorID, D.NameFirst + ' ' + D.NameLast 'CompanyName', D.Phone1, D.Email, D.EnrollDate, D.VisitDate From Member As A
Join Member As B On A.MemberID = B.MentorID
Join Member As C On B.MemberID = C.MentorID
Join Member As D On C.MemberID = D.MentorID
Where A.MentorID = @MemberID
Order By EnrollDate

GO