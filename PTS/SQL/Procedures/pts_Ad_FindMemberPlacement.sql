EXEC [dbo].pts_CheckProc 'pts_Ad_FindMemberPlacement'
 GO

CREATE PROCEDURE [dbo].pts_Ad_FindMemberPlacement ( 
   @SearchText nvarchar (10),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
   @MemberID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20

SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), adv.Placement), '') + dbo.wtfn_FormatNumber(adv.AdID, 10) 'BookMark' ,
            adv.AdID 'AdID' ,
            adv.CompanyID 'CompanyID' ,
            adv.MemberID 'MemberID' ,
            me.CompanyName 'MemberName' ,
            adv.AdName 'AdName' ,
            adv.Status 'Status' ,
            adv.Msg 'Msg' ,
            adv.Placement 'Placement' ,
            adv.RefID 'RefID' ,
            adv.Priority 'Priority' ,
            adv.POrder 'POrder' ,
            adv.Zip 'Zip' ,
            adv.City 'City' ,
            adv.MTA 'MTA' ,
            adv.State 'State' ,
            adv.StartAge 'StartAge' ,
            adv.EndAge 'EndAge' ,
            adv.StartDate 'StartDate' ,
            adv.EndDate 'EndDate' ,
            adv.MaxPlace 'MaxPlace' ,
            adv.Places 'Places' ,
            adv.Clicks 'Clicks' ,
            adv.Rotation 'Rotation' ,
            adv.Weight 'Weight'
FROM Ad AS adv (NOLOCK)
LEFT OUTER JOIN Member AS me (NOLOCK) ON (adv.MemberID = me.MemberID)
WHERE ISNULL(CONVERT(nvarchar(10), adv.Placement), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), adv.Placement), '') + dbo.wtfn_FormatNumber(adv.AdID, 10) >= @BookMark
AND         (adv.CompanyID = @CompanyID)
AND         (adv.MemberID = @MemberID)
ORDER BY 'Bookmark'

GO