EXEC [dbo].pts_CheckProc 'pts_Affiliate_Genealogy'
GO

CREATE PROCEDURE [dbo].pts_Affiliate_Genealogy
   @AffiliateID int 

AS

Select A.AffiliateID, A.SponsorID, A.NameFirst + ' ' + A.NameLast 'CompanyName', A.Rank, A.Email, A.EnrollDate, A.Status From Affiliate As A
Where A.SponsorID = @AffiliateID
Union All
Select B.AffiliateID, B.SponsorID, B.NameFirst + ' ' + B.NameLast 'CompanyName', B.Rank, B.Email, B.EnrollDate, B.Status From Affiliate As A
Join Affiliate As B On A.AffiliateID = B.SponsorID
Where A.SponsorID = @AffiliateID
Union All
Select C.AffiliateID, C.SponsorID, C.NameFirst + ' ' + C.NameLast 'CompanyName', C.Rank, C.Email, C.EnrollDate, C.Status From Affiliate As A
Join Affiliate As B On A.AffiliateID = B.SponsorID
Join Affiliate As C On B.AffiliateID = C.SponsorID
Where A.SponsorID = @AffiliateID
Union All
Select D.AffiliateID, D.SponsorID, D.NameFirst + ' ' + D.NameLast 'CompanyName', D.Rank, D.Email, D.EnrollDate, D.Status From Affiliate As A
Join Affiliate As B On A.AffiliateID = B.SponsorID
Join Affiliate As C On B.AffiliateID = C.SponsorID
Join Affiliate As D On C.AffiliateID = D.SponsorID
Where A.SponsorID = @AffiliateID
Order By EnrollDate

GO