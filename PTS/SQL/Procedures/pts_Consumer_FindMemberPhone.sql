EXEC [dbo].pts_CheckProc 'pts_Consumer_FindMemberPhone'
 GO

CREATE PROCEDURE [dbo].pts_Consumer_FindMemberPhone ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (30),
   @MaxRows tinyint OUTPUT,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(csm.Phone, '') + dbo.wtfn_FormatNumber(csm.ConsumerID, 10) 'BookMark' ,
            csm.ConsumerID 'ConsumerID' ,
            csm.MemberID 'MemberID' ,
            csm.MerchantID 'MerchantID' ,
            csm.ReferID 'ReferID' ,
            csm.CountryID 'CountryID' ,
            csm.CountryID2 'CountryID2' ,
            csm.AffiliateID 'AffiliateID' ,
            cou.CountryName 'CountryName' ,
            csm.NameLast 'NameLast' ,
            csm.NameFirst 'NameFirst' ,
            LTRIM(RTRIM(csm.NameLast)) +  ', '  + LTRIM(RTRIM(csm.NameFirst)) 'ConsumerName' ,
            csm.Email 'Email' ,
            csm.Email2 'Email2' ,
            csm.Phone 'Phone' ,
            csm.Provider 'Provider' ,
            csm.Password 'Password' ,
            csm.Status 'Status' ,
            csm.Messages 'Messages' ,
            csm.Street1 'Street1' ,
            csm.Street2 'Street2' ,
            csm.City 'City' ,
            csm.State 'State' ,
            csm.Zip 'Zip' ,
            csm.City2 'City2' ,
            csm.State2 'State2' ,
            csm.Zip2 'Zip2' ,
            csm.Referrals 'Referrals' ,
            csm.Cash 'Cash' ,
            csm.Points 'Points' ,
            csm.VisitDate 'VisitDate' ,
            csm.EnrollDate 'EnrollDate' ,
            csm.UserKey 'UserKey' ,
            csm.Barter 'Barter'
FROM Consumer AS csm (NOLOCK)
LEFT OUTER JOIN Country AS cou (NOLOCK) ON (csm.CountryID = cou.CountryID)
WHERE ISNULL(csm.Phone, '') LIKE @SearchText + '%'
AND ISNULL(csm.Phone, '') + dbo.wtfn_FormatNumber(csm.ConsumerID, 10) >= @BookMark
AND         (csm.MemberID = @MemberID)
AND         (csm.ReferID = 0)
ORDER BY 'Bookmark'

GO