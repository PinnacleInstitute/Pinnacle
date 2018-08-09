EXEC [dbo].pts_CheckProc 'pts_Email_FindSendDate'
 GO

CREATE PROCEDURE [dbo].pts_Email_FindSendDate ( 
   @SearchText nvarchar (20),
   @Bookmark nvarchar (20),
   @MaxRows tinyint OUTPUT,
   @CompanyID int,
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
            ISNULL(CONVERT(nvarchar(10), ema.SendDate, 112), '') + dbo.wtfn_FormatNumber(ema.EmailID, 10) 'BookMark' ,
            ema.EmailID 'EmailID' ,
            ema.CompanyID 'CompanyID' ,
            ema.NewsLetterID 'NewsLetterID' ,
            ema.EmailListID 'EmailListID' ,
            ema.EmailName 'EmailName' ,
            ema.FromEmail 'FromEmail' ,
            ema.Subject 'Subject' ,
            ema.FileName 'FileName' ,
            ema.Status 'Status' ,
            ema.SendDate 'SendDate' ,
            ema.Repeat 'Repeat' ,
            ema.EndDate 'EndDate' ,
            ema.Mailings 'Mailings' ,
            ema.Emails 'Emails' ,
            ema.TestEmail 'TestEmail' ,
            ema.TestFirstName 'TestFirstName' ,
            ema.TestLastName 'TestLastName' ,
            ema.TestData1 'TestData1' ,
            ema.TestData2 'TestData2' ,
            ema.TestData3 'TestData3' ,
            ema.TestData4 'TestData4' ,
            ema.TestData5 'TestData5' ,
            ema.EmailType 'EmailType' ,
            ema.IsSalesStep 'IsSalesStep'
FROM Email AS ema (NOLOCK)
WHERE ISNULL(CONVERT(nvarchar(10), ema.SendDate, 112), '') LIKE @SearchText + '%'
AND ISNULL(CONVERT(nvarchar(10), ema.SendDate, 112), '') + dbo.wtfn_FormatNumber(ema.EmailID, 10) <= @BookMark
AND         (ema.CompanyID = @CompanyID)
AND         (ema.EmailType = 1)
ORDER BY 'Bookmark' DESC

GO