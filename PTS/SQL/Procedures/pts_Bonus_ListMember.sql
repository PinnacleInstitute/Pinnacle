EXEC [dbo].pts_CheckProc 'pts_Bonus_ListMember'
GO

CREATE PROCEDURE [dbo].pts_Bonus_ListMember
   @MemberID int
AS

SET NOCOUNT ON

SELECT      bo.BonusID, 
         bo.BonusDate, 
         ti.TitleName AS 'TitleName', 
         bo.BV, 
         bo.QV, 
         bo.Total, 
         bo.PaidDate, 
         bo.Reference, 
         bo.IsPrivate
FROM Bonus AS bo (NOLOCK)
LEFT OUTER JOIN Title AS ti (NOLOCK) ON (bo.CompanyID = ti.CompanyID AND bo.Title = ti.TitleNo)
WHERE (bo.MemberID = @MemberID)
 AND (bo.IsPrivate = 0)

ORDER BY   bo.BonusDate DESC

GO