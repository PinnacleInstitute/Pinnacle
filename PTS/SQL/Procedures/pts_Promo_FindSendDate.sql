EXEC [dbo].pts_CheckProc 'pts_Promo_FindSendDate'
 GO

CREATE PROCEDURE [dbo].pts_Promo_FindSendDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @MerchantID int,
   @UserID int
      )
AS


SET NOCOUNT ON

SET @MaxRows = 20
IF (@Bookmark = '') SET @Bookmark = '99991231'
IF (ISDATE(@SearchText) = 1)
            SET @SearchText = CONVERT(nvarchar(10), CONVERT(datetime, @SearchText), 112)
ELSE
            SET @SearchText = ''


SELECT TOP 21
            ISNULL(CONVERT(nvarchar(10), prm.SendDate, 112), '') + dbo.wtfn_FormatNumber(prm.PromoID, 10) 'BookMark' ,
            prm.PromoID 'PromoID' ,
            prm.MerchantID 'MerchantID' ,
            prm.CountryID 'CountryID' ,
            prm.PromoName 'PromoName' ,
            prm.FromEmail 'FromEmail' ,
            prm.Subject 'Subject' ,
            prm.Message 'Message' ,
            prm.Status 'Status' ,
            prm.TargetArea 'TargetArea' ,
            prm.TargetType 'TargetType' ,
            prm.TargetDays 'TargetDays' ,
            prm.Target 'Target' ,
            prm.StartDate 'StartDate' ,
            prm.EndDate 'EndDate' ,
            prm.SendDate 'SendDate' ,
            prm.Msgs 'Msgs' ,
            prm.TestEmail 'TestEmail'
FROM Promo AS prm (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), prm.SendDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), prm.SendDate, 112), '') + dbo.wtfn_FormatNumber(prm.PromoID, 10) <= @BookMark
AND         (prm.MerchantID = @MerchantID)
ORDER BY 'Bookmark' DESC

GO