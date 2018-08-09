EXEC [dbo].pts_CheckProc 'pts_Email_Fetch'
 GO

CREATE PROCEDURE [dbo].pts_Email_Fetch ( 
   @EmailID int,
   @CompanyID int OUTPUT,
   @NewsLetterID int OUTPUT,
   @EmailListID int OUTPUT,
   @EmailName nvarchar (60) OUTPUT,
   @FromEmail nvarchar (60) OUTPUT,
   @Subject nvarchar (80) OUTPUT,
   @FileName nvarchar (20) OUTPUT,
   @Status int OUTPUT,
   @SendDate datetime OUTPUT,
   @Repeat nvarchar (5) OUTPUT,
   @EndDate datetime OUTPUT,
   @Mailings int OUTPUT,
   @Emails int OUTPUT,
   @TestEmail nvarchar (80) OUTPUT,
   @TestFirstName nvarchar (30) OUTPUT,
   @TestLastName nvarchar (30) OUTPUT,
   @TestData1 nvarchar (80) OUTPUT,
   @TestData2 nvarchar (80) OUTPUT,
   @TestData3 nvarchar (80) OUTPUT,
   @TestData4 nvarchar (80) OUTPUT,
   @TestData5 nvarchar (80) OUTPUT,
   @EmailType int OUTPUT,
   @IsSalesStep bit OUTPUT,
   @UserID int
      )
AS


SET NOCOUNT ON


SELECT   @CompanyID = ema.CompanyID ,
   @NewsLetterID = ema.NewsLetterID ,
   @EmailListID = ema.EmailListID ,
   @EmailName = ema.EmailName ,
   @FromEmail = ema.FromEmail ,
   @Subject = ema.Subject ,
   @FileName = ema.FileName ,
   @Status = ema.Status ,
   @SendDate = ema.SendDate ,
   @Repeat = ema.Repeat ,
   @EndDate = ema.EndDate ,
   @Mailings = ema.Mailings ,
   @Emails = ema.Emails ,
   @TestEmail = ema.TestEmail ,
   @TestFirstName = ema.TestFirstName ,
   @TestLastName = ema.TestLastName ,
   @TestData1 = ema.TestData1 ,
   @TestData2 = ema.TestData2 ,
   @TestData3 = ema.TestData3 ,
   @TestData4 = ema.TestData4 ,
   @TestData5 = ema.TestData5 ,
   @EmailType = ema.EmailType ,
   @IsSalesStep = ema.IsSalesStep
FROM Email AS ema (NOLOCK)
WHERE ema.EmailID = @EmailID

GO